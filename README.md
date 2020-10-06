# Tract-Pulse Exchange

Practice in MATLAB for the exchange of tract and pulse of two audios.

The practice was carried out for the subject _Applications of Voice Biometrics_ (ETSIINF-UPM 2019).

## How it works

The program separates the tract and the pulse of an audio using an LPC (_Linear Predictive Coding_) estimator, in such a way that the vocal tract is modeled as a filter (_to delve into the theoretical foundations, see [Memoria.pdf](docs/Memoria.pdf)_).

- The function `separa.m` divides the vector of the audio signal into:
  - `P`: Glottic pulse matrix
  - `A`: Matrix of LPC coefficients that models the tract.
- The function `join.m` recomposes the signal from the matrices `A` and`P` obtained with the function `separa.m`.

Both functions allow you to apply a pre-emphasis or de-emphasis filter to reduce the noise created by mixing tract and pulse of two different audios (_see [nofilter.wav](outputs/nofilter.wav) - [filter.wav](outputs/filter.wav)_)

Graphical functions are also included for analysis and study purposes:

- `graficas_tracto.m`: Generates spectrograms of the vocal tract.

- `graficas_pulso.m`:  Generates graph and spectrogram to visualize glottic pulse and glottic wave.
- `graficas_formantes.m`: Generates a graph with the FFT, LPC and LPC envelopes over a frame of the signal.

The file `test.m` contains an example code for separating and recomposing audio, as well as generating graphs, playing the resulting audios and saving files.

## GUI

<p align="center">
<img src="https://user-images.githubusercontent.com/5247088/95152955-88fd8a80-078e-11eb-8ad6-d810e1853fba.png">
<br>GUI
</p>

The graphical interface allows loading and previewing the wave of two files in __WAV__ format (<span style="color:blue">mono</span>, <span style="color:orange">estereo</span>). Allowing to choose from a list, the files in the `wav` folder, or loading another file by clicking on __[Browse]__.

__The two files must have the same sample rate__.

The interface allows you to configure the pre-emphasis and de-emphasis filters, the size and overlap of the window, and the number of coefficients to use. __CAUTION: Using a custom overlap can cause errors!__

The __[RUN]__ button executes the division and recomposition of the audios that are played with the __[Tract X - Pulse Y]__ buttons.

The lower buttons allow to generate the graphs corresponding to each audio.

<p align="center">
<img src="https://user-images.githubusercontent.com/5247088/95154273-bf88d480-0791-11eb-9453-2c9804505078.png">
<br>Formant Plot
</p>



## Outputs

By mixing the tract and pulse of two different voices, it is possible to generate new audios in which the message of one speaker is maintained with the voice of the other. As they are different audios, the message is not very clear and, sometimes, messages from the two audios can overlap. Some results are funny like [this](outputs/pulso-prat_tracto-sheldon.wav) that mixes the pulse of [Matias Prat](code/wavs/prat.wav) and the tract of [Fernando Cabrera (_Spanish voice of Sheldon Cooper in The Big Bang Theory_)](code/wavs/sheldon.wav).

If we mix the audio of a speaker with a musical note we can "tune" the voice of the speaker to a specific frequency (with a quite robotic tone). For example:

- Tract of [Miguel Ángel Jenner (_Spanish voice of Jules Winnfield in Pulp Fiction_)](code/wav/pulp.wav) + Pulse [note Mi1 (_E2: 82.41Hz_)](nota_E_82-41Hz_cont.wav) = [Jules in Mi1](outputs/pulp_E82-41Hz.wav)
- Tract of [Miguel Ángel Jenner (_Spanish voice of Jules Winnfield in Pulp Fiction_)](code/wav/pulp.wav) + Pulse [note Mi3 (_E4: 329.6280Hz_)](nota_e_329-63Hz_cont.wav) = [Jules en Mi3](outputs/pulp_e329-63Hz.wav)
- Tract of [Miguel Ángel Jenner (_Spanish voice of Jules Winnfield in Pulp Fiction_)](code/wav/pulp.wav) + Pulse [Asturias (_Isaac Albéniz_)](code/wav/albeniz_amplificado.wav) = [Jules singing Asturias](outputs/pulso-albeniz_tracto-pulp.wav)

The result is Miguel Ángel Jenner's tract, as if his vocal cords are vibrating at the frequency at which the guitar strings vibrate on each note.