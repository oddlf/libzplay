#ifndef _W_CONFIG_H_
#define _W_CONFIG_H_

#ifndef LIBZPLAY_PF_VERSION
	#define LIBRARY_VERSION 212
	#define RC_VERSION 2, 1, 2, 0
	#define RC_FILE_VERSION "2.12\0"
	#define RC_PRODUCT_VERSION "2.12\0"
	#define RC_FILE_DESCRIPTION "libZPlay library\0"
	#define RC_COMMENTS "Library for playing mp3,ogg,flac,ac3,aac,wav,pcm files\0"
#else
	#define LIBRARY_VERSION 211
	#define RC_VERSION 2, 1, 1, 0
	#define RC_FILE_VERSION "2.11\0"
	#define RC_PRODUCT_VERSION "2.11\0"
	#define RC_FILE_DESCRIPTION "libZPlay library PF\0"
	#define RC_COMMENTS "Library for playing mp3,ogg,flac,ac3,wav,pcm files\0"
#endif

#endif
