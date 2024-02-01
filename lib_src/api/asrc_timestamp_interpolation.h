// Copyright 2024 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.

#ifndef _asrc_timestamp_interpolation_h_
#define _asrc_timestamp_interpolation_h_

#include "src.h"

#ifdef __XC__
#define UNSAFE unsafe
#else
#define UNSAFE
#endif

/**
 * Function that interpolates a timestamp for a sample generated by the ASRC.
 * Given a measured timestamp for the sample going into the ASRC, the asrc control
 * structure, and the expected output frequency, this function returns a timestamp
 * for when the last sample was produced by the ASRC.
 *
 * @param  timestamp       Value of the reference clock taken when the last sample
 *                         fed into the ASRC was sampled.
 *
 * @param  asrc_ctrl       ASRC control block
 *
 * @param  ideal_freq      Expected base frequency to which the ASRC is operating;
 *                         eg, 48000 or 44100
 *                         TBD - WHAT IS THIS NUMBER?
 */
int asrc_timestamp_interpolation(int timestamp, asrc_ctrl_t * UNSAFE asrc_ctrl, int ideal_freq);

#endif
