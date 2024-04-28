# libZPlay multimedia library

**libZPlay is a simple and easy-to-use audio library for windows.**  

`libZPlay` is a fork of libZPlay v2.02 that aims to improve it.  

## Supported formats

 - MP3  -> mp3, mp2, mp1  MPEG-1, MPEG-2, MPEG 2.5 - Layer I, Layer II, Layer III.
           Read topic 9: MP3 and AAC LICENSE
 - OGG  -> ogg  VORBIS OGG
 - AC3  -> A/52 aka. ac3
 - AAC  -> HE, LC, MAIN and LTP profile, MPEG2 and MPEG-4 AAC decoder.
           Read topic 9: MP3 and AAC LICENSE
 - FLAC -> flac, oga  Native FLAC and OGG flac
 - WAVE -> wav  PCM WAVE with RIFF header, uncompressed, 8, 16 bit per sample
 - PCM  -> any file  Raw PCM audio format, uncomressed, 8 16 bit per sample

## Features

 - supports mp3, ogg, flac, ac3, aac, wav, pcm
 - supports wave-in input (get samples from line-in, microphone, ....)
 - supports encoding samples into mp3, ogg, flac, wave and aac streams
 - UNICODE support for functions using strings ( filename, error messages, ID3 info, ... )
 - read info tags from file ( ID3v1, ID3v2, VORBIS comment, wave RIFF list, FLAC VORBIS comment, embeded picture )
 - easy drawing embeded picture to screen
 - REVERSE PLAYING (you can play song backward in real time, "real" backward playing without predecoding in PCM)
 - built in equaliter, user can specify own subbands, add subbands, ...
 - built in echo and reverb sound processor
 - pitch/rate/tempo change
 - stereo cut effect
 - detect beat-per-minute using 2 methods ( peak detection and autocorrelation)
 - loop playing (you can play just one portion of file, repeat this portion ... )
 - channel mixer (you can mix left and right chanel, convert stereo to mono ... )
 - volume slide control (fade-in and fade-out)
 - internal volume control (without affecting wave out device volume)
 - pulling VU meter data (you can simply create VU meter)
 - pulling FFT data (you can simply build FFT spectrum analyzer)
 - built in FFT spectrum graph, library will draw complete spectrum graph on your window
 - callback mechanism (class will inform you about events like play, stop, fade, ...)
 - access to decoded PCM data throug callback message
 - play data from disk files, UNICODE SUPPORT
 - play data from allocated memory
 - play dynamic streams (push small memory chunks into stream while song is playing, for download streams)
 - selecting wave output (for multiple waveout devices)
 - easy play, pause, seek ...
 - class interface for Visual C++ .NET, Visual Basic .NET, C# .NET and Delphi.

## Documentation

[documentation](doc_src)

## license

`libZPlay` is released under GNU GPL license.
Check [License.txt](License.txt) for further details.
