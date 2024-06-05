# IEEE Signal Processing Cup 2024 - Team Wavemasters

## Team Members
- Nidula Gunawardana
- [Lasindu Dilshan](https://github.com/LasiduDilshan)
- [Nilupulee Amarathunga](https://github.com/NilupuleeA)
- Erandee Jayathilaka
- Dasuni Herath
- [Nimshi Wanniarachchi](https://github.com/NimsW20)
- Mavishan Pasira
- Chandeepa Janith
- Shemal Perera
- Mihiraja Kuruppu

**Department of Electronic and Telecommunication Engineering  
University of Moratuwa, Sri Lanka**

---

## Table of Contents
- [IEEE Signal Processing Cup 2024 - Team Wavemasters](#ieee-signal-processing-cup-2024---team-wavemasters)
  - [Team Members](#team-members)
  - [Table of Contents](#table-of-contents)
  - [Abstract](#abstract)
  - [Introduction](#introduction)
  - [Methodology](#methodology)
    - [Noise Removing and Amplifying Method using Wavelet Transform](#noise-removing-and-amplifying-method-using-wavelet-transform)
      - [Signal Denoising using Wavelet Transform:](#signal-denoising-using-wavelet-transform)
    - [System Design](#system-design)
      - [Feature Extraction](#feature-extraction)
      - [Data Augmentation Techniques](#data-augmentation-techniques)
      - [VGGish Pre-trained Model](#vggish-pre-trained-model)
  - [Experiment and Results](#experiment-and-results)
  - [Discussion and Conclusion](#discussion-and-conclusion)
  - [References](#references)

---

## Abstract

The IEEE Signal Processing Cup 2024 challenges participants to address the problem of text-independent far-field speaker recognition under noise and reverberation conditions for mobile robots. This paper presents the approach and results of Team Wavemasters in tackling this challenge. Leveraging signal processing techniques and machine learning algorithms, our solution aims to robustly identify speakers from speech signals captured by mobile robots amidst challenging acoustic environments. Key components of our approach include feature extraction, noise mitigation, and speaker verification methods tailored for real-world scenarios. Through rigorous experimentation and evaluation on the provided dataset, our solution demonstrates promising performance in addressing the complexities of far-field speaker recognition for mobile robotics applications.

---

## Introduction

Speaker recognition systems have evolved rapidly, propelled by advancements in deep learning and signal processing techniques. These systems play a vital role in verifying the identity of individuals based on their speech characteristics, finding applications in security, access control, and personalized services. However, existing speaker recognition systems often struggle in far-field environments, where noise, reverberation, and variable speaker-to-microphone distances introduce significant challenges.

The IEEE Signal Processing Cup 2024 presents a novel challenge in text-independent far-field speaker recognition for mobile robots. In this competition, participants are tasked with developing robust speaker verification pipelines capable of accurately identifying speakers from speech signals captured by mobile robots under adverse conditions. The competition seeks to bridge the gap between theoretical advancements in speaker recognition and real-world applications, particularly in dynamic environments where mobile robots interact with human speakers amidst varying acoustic conditions.

Team Wavemasters approaches this challenge with a combination of signal processing algorithms and machine learning models tailored to the characteristics of far-field speech signals. Our solution aims to extract discriminative features from noisy and reverberant speech signals, mitigate the effects of environmental factors, and perform speaker verification with high accuracy and efficiency. By addressing the specific challenges posed by mobile robotics environments, our solution aims to advance the state-of-the-art in far-field speaker recognition technology and pave the way for practical applications in real-world settings.

---

## Methodology

### Noise Removing and Amplifying Method using Wavelet Transform

We have used wavelet transform, a mathematical tool for analyzing signals and images in terms of different frequency components to process the audio signal. Unlike the Fourier transform, which represents a signal in the frequency domain, the wavelet transform represents both frequency and time information. This makes wavelet transform particularly useful for analyzing signals with non-stationary or time-varying characteristics.

#### Signal Denoising using Wavelet Transform:
1. **Decomposition**: The initial phase of the signal denoising process involved the application of the Discrete Wavelet Transform (DWT). This transformative step decomposes the input signal into a set of approximation and detail coefficients at multiple scales. The approximation coefficients encapsulate the coarse, low-frequency components of the signal, while the detail coefficients capture the nuanced, high-frequency details.
2. **Thresholding**: After decomposition, our next step in the denoising methodology was the application of thresholding to the detail coefficients. Soft and hard thresholding techniques were employed for this purpose. Soft thresholding selectively sets coefficients below a predetermined threshold to zero, effectively attenuating noise and contributing to a smoother denoised signal. On the other hand, hard thresholding zeros coefficients fall below the specified threshold, thereby eliminating noise from the signal.
3. **Reconstruction**: Following the thresholding phase, the denoised signal was reconstructed using the modified coefficients. Notably, in the reconstruction process, we omitted the approximation coefficients from the highest scale. This omission was deemed acceptable as high-frequency details are considered non-critical for the denoised output.
4. **Iterative Processing**: The above steps were iteratively applied to enhance the denoising performance further.

Wavelet-based denoising is effective when the signal and noise have different frequency characteristics. Choosing an appropriate wavelet, thresholding method, and threshold value were critical in achieving optimal denoising results.

*Note*: The sampling rate used in both noisy and denoised signals is 16kHz. Therefore we did not experience any time scaling.

![alt](Pictures/Screenshot%202024-06-05%20234008.png)

### System Design

#### Feature Extraction

We focused on robust feature extraction from audio soundtracks to lay the groundwork for subsequent model training. We adopted the first approach, utilizing Mel-Frequency Cepstral Coefficients (MFCCs) as a representative feature set for audio signal characterization in the frequency domain. The MFCC plot served as a visual representation, depicting variations in the spectral content over time. This plot encapsulates crucial information such as time versus frequency dynamics, aiding in the observation of distinct sound patterns and the extraction of relevant features.

The MFCC coefficients, crucial in audio processing tasks, were extracted using the `librosa` library’s dedicated MFCC feature extraction method. Each row in the resulting array represented the MFCC coefficients for a specific time frame, while each column corresponded to a distinct MFCC feature. The significance of individual coefficients was detailed, ranging from capturing overall energy (MFCC 0) to nuanced spectral characteristics (higher-order coefficients). The number of coefficients could be adjusted, with a maximum stable limit of 40, allowing for flexibility in representing the audio signal’s complexity.

This feature extraction methodology served as the foundation for subsequent model training, providing a rich representation of audio characteristics essential for tasks such as speaker identification, emotion recognition, and speech-to-text.

#### Data Augmentation Techniques

To address the limited availability of training data, data augmentation techniques were employed to generate additional soundtracks. Techniques such as Gaussian noise addition, time stretching, pitch scaling, and random gain modulation were implemented to augment the existing dataset. Each technique was carefully calibrated to produce diverse audio samples while preserving the underlying characteristics of the original data. The augmented dataset provided a larger pool of training examples, thereby enhancing the model’s ability to generalize to unseen data. Model performance was evaluated based on accuracy improvements achieved through data augmentation.

#### VGGish Pre-trained Model

We used a pre-trained model called VGGish from TensorFlow, specifically designed for audio classification tasks. VGGish is capable of extracting high-level semantic embeddings from audio input, providing a compact representation that preserves essential features for downstream classification tasks. The pre-trained model was utilized to extract 128-dimensional embeddings from denoised test files, which were subsequently fed into a downstream classification model. Model performance was evaluated based on the accuracy of speaker identification achieved using the VGGish embeddings. Cosine similarity calculations were performed to assess the similarity between enrollment clips and test files, providing insights into the effectiveness of the VGGish model for speaker identification tasks.

---

## Experiment and Results

This study has used Python TensorFlow software for implementation. Experiments are carried out on 78 different speakers featuring between 24 and 36 conversations per speaker, resulting in a total of 2219 conversations. On average each conversation consists of 5 dialogues, totaling approximately 11000 recorded dialogues. The database consists of speech signals, sample data frequency of 16KHz and of duration within 3.6 seconds and recordings are made with 8 channels. Each speaker engaged in conversations with the robot, introducing complexities such as ambient noise, internal robot noises, reverberation, varying distances, babble noise, and speaker angles.

Our approach commenced with robust preprocessing, including wavelet-based denoising using Discrete Wavelet Transform (DWT). This method effectively handled non-stationary characteristics, resulting in enhanced denoised signals crucial for downstream analysis. We then focused on feature extraction, utilizing Mel-Frequency Cepstral Coefficients (MFCCs) and VGGish pre-trained models from TensorFlow. The choice of MFCCs provided a comprehensive representation of audio characteristics, while VGGish embeddings captured high-level semantic features. Data augmentation techniques, such as Gaussian noise addition and time stretching, were employed to address limited training data, enhancing the model’s ability to generalize. The VGGish pre-trained model, specifically designed for audio classification, demonstrated its proficiency in extracting 128-dimensional embeddings for downstream tasks.

Evaluation results across different scenarios highlighted the robustness of our solution. In text-independent far-field speaker recognition, our model showcased promising accuracy rates under challenging conditions. The experiments, including short and long utterance tests, validated the effectiveness of our approach in handling diverse scenarios presented in the Robovox dataset. Team Wavemasters’ experiments yielded favourable results, showcasing the applicability and efficacy of our solution in addressing the complexities of far-field speaker recognition for mobile robots.

---

## Discussion and Conclusion

The speaker recognition system serves the purpose of measuring the distance between two audio files, utilizing embeddings generated for each speaker and the respective audio file. The cosine distance calculation between these embeddings provides a quantitative measure of the similarity or dissimilarity between the audio files.

The Mel-Frequency Cepstral Coefficients (MFCCs) and embeddings derived from the VGGish model are vital for the analysis as they demonstrate crucial features within each audio file. The comparative evaluation of these features enables a detailed assessment of the similarity between any two given audio files.

To enhance the precision of the results, the system employs robust noise removal methods and ensures the accurate extraction of features. These measures contribute significantly to achieving more refined and reliable outcomes in the recognition process.

The collaborative experience gained as a team during the development of this system is invaluable in effectively addressing such challenges.

---

## References

1. Homayoon Beigi. (2011) “Fundamentals of Speaker Recognition”. Springer.
2. Robert C. Maher and Allen R. Robinson. (2013) “Noise and Vibration Control Engineering: Principles and Applications”. John Wiley & Sons.
3. Douglas A. Reynolds, Thomas F. Quatieri, and Robert B. Dunn. (2000) “Speaker Verification Using Adapted Gaussian Mixture Models”. Digital Signal Processing.
4. Lawrence Rabiner and Ronald Schafer. (2010) “Theory and Applications of Digital Speech Processing”. Prentice Hall.
5. Daniel P. W. Ellis, Brian Whitman, Adam Berenzweig, and Steve Lawrence. (2002) “The Quest for Ground-Truth in Musical Artist Similarity”. ISMIR.
6. DeLiang Wang and Jitong Chen. (2018) “Supervised Speech Separation Based on Deep Learning: An Overview”. IEEE/ACM Transactions on Audio, Speech, and Language Processing.
