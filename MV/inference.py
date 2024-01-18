import torch
import torchaudio
from urbansounddataset import UrbanSoundDataset
from cnn import CNNNetwork
from train import AUDIO_DIR, SAMPLE_RATE, NUM_SAMPLES


class_mapping = [
    "Benjamin netanyau",
    "Jens stohenberg",
    "Julia Gillard",
    "Margaret Tracher",
    "Nelson Mandela",
    "5",
    "6",
    "7",
    "8",
    "9"
]


def predict(model, input, target, class_mapping):
    model.eval()
    with torch.no_grad():
        predictions = model(input)
        # Tensor (1, 10) -> [ [0.1, 0.01, ..., 0.6] ]
        predicted_index = predictions[0].argmax(0)
        predicted = class_mapping[predicted_index]
        expected = class_mapping[target]
    return predicted, expected


if __name__ == "__main__":
    # load back the model
    cnn = CNNNetwork()
    state_dict = torch.load("feedforwardnet.pth")
    cnn.load_state_dict(state_dict)

    #load urbansound dataset
    mel_spectrogram = torchaudio.transforms.MelSpectrogram(
        sample_rate=SAMPLE_RATE,
        n_fft=1024,
        hop_length=512,
        n_mels=64
    )

    usd = UrbanSoundDataset("C:/Users/Ramesh/Desktop/test1/Book1.csv",
                            AUDIO_DIR,
                            mel_spectrogram,
                            SAMPLE_RATE,
                            NUM_SAMPLES,
                            "cpu")

    # get a sample from the urban sound dataset for inference
    input, target = usd[3324][0], usd[3324][1]  #[batch size, num_channels, fr, time]
    input.unsqueeze_(0)
    

    # make an inference
    predicted, expected = predict(cnn, input, target,
                                  class_mapping)
    print(f"Predicted: '{predicted}', expected: '{expected}'")
