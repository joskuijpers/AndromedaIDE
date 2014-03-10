/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef SRK_ENDIAN_H
#define SRK_ENDIAN_H

#include <stdint.h>

#define SPHERE_LITTLE_ENDIAN 0
#define SPHERE_BIG_ENDIAN    1

#if defined(__BIG_ENDIAN__)
# define SPHERE_BYTEORDER SPHERE_BIG_ENDIAN
#else
# define SPHERE_BYTEORDER SPHERE_LITTLE_ENDIAN
#endif

#if SPHERE_BYTEORDER == SPHERE_LITTLE_ENDIAN

#define ltom_w(x) (x)
#define mtol_w(x) (x)
#define ltom_d(x) (x)
#define mtol_d(x) (x)

inline uint16_t btom_w(const uint16_t in)
{
    return (in & 0xFF00 >> 8) + (in & 0x00FF << 8);
}

inline uint16_t mtob_w(const uint16_t in)
{
    return (in & 0xFF00 >> 8) + (in & 0x00FF << 8);
}

inline uint32_t btom_d(const uint32_t in)
{
    return (in & 0xFF000000 >> 24) +
	(in & 0x00FF0000 >> 8) +
	(in & 0x0000FF00 << 8) +
	(in & 0x000000FF << 24);
}

inline uint32_t mtob_d(const uint32_t in)
{
    return (in & 0xFF000000 >> 24) +
	(in & 0x00FF0000 >> 8) +
	(in & 0x0000FF00 << 8) +
	(in & 0x000000FF << 24);
}

inline float ltom_f(uint8_t in[4])
{
	float out = 0.0;
	uint8_t *fp = (uint8_t *)&out;

	fp[0] = in[0];
	fp[1] = in[1];
	fp[2] = in[2];
	fp[3] = in[3];

	return out;
}

inline void mtol_f(uint8_t *out, const float in)
{
	uint8_t *fp = (uint8_t *)&in;

	out[0] = fp[0];
	out[1] = fp[1];
	out[2] = fp[2];
	out[3] = fp[3];
}

#elif SPHERE_BYTEORDER == SPHERE_BIG_ENDIAN

#define btom_w(x) (x)
#define mtob_w(x) (x)
#define btom_d(x) (x)
#define mtob_d(x) (x)

inline uint16_t ltom_w(uint16_t in)
{
	return ((in >>8) | (in << 8));
}

inline uint16_t mtol_w(uint16_t in)
{
	return ((in >>8) | (in << 8));
}

inline uint32_t ltom_d(uint32_t in)
{
    return ((in >> 24) |
            ((in & 0x00FF0000) >> 8)  |
            ((in & 0x0000FF00) << 8)  |
            ((in & 0x000000FF) << 24));
}

inline uint32_t mtol_d(uint32_t in)
{
    return ((in >> 24) |
            ((in & 0x00FF0000) >> 8)  |
            ((in & 0x0000FF00) << 8)  |
            ((in & 0x000000FF) << 24));
}

inline float ltom_f(uint8_t in[4])
{
    float out;
    uint8_t *fp = (uint8_t *)&out;

    fp[0] = in[3];
    fp[1] = in[2];
    fp[2] = in[1];
    fp[3] = in[0];

    return out;
}

inline void mtol_f(uint8_t *out, float in)
{
    uint8_t *fp = (uint8_t *)&in;

    out[0] = fp[3];
    out[1] = fp[2];
    out[2] = fp[1];
    out[3] = fp[0];

}

#endif

#endif // SRK_ENDIAN_H