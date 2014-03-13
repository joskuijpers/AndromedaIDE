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

/**
 * Read a structure from a databuffer, verifying its size and updating
 * the seek position.
 *
 * This function verifies that the struct can be read from the buffer.
 *
 * @param data NSData object holding the filedata
 * @param filePos Reference to the file seek value
 * @param filePos Pointer to the seek position store
 * @return Pointer to the data or NULL when no data enough
 */
void *srk_file_read_struct(NSData *data, size_t size, size_t *filePos);

/**
 * Read a single byte from the file, and proceed the seek value.
 *
 * This function verifies that the byte can be read from the buffer.
 *
 * @param data NSData object holding the filedata
 * @param filePos Reference to the file seek value
 * @param value Value gotten from the data
 * @return YES on success, NO otherwise
 */
BOOL srk_file_read_byte(NSData *data, size_t *filePos, uint8_t *value);

/**
 * Read a single word from the file, and proceed the seek value.
 *
 * This function verifies that the word can be read from the buffer.
 *
 * @param data NSData object holding the filedata
 * @param filePos Reference to the file seek value
 * @param value Value gotten from the data
 * @return YES on success, NO otherwise
 */
BOOL srk_file_read_word(NSData *data, size_t *filePos, uint16_t *value);

/**
 * Read a doubleword from the file, and proceed the seek value.
 *
 * This function verifies that the dword can be read from the buffer.
 *
 * @param data NSData object holding the filedata
 * @param filePos Reference to the file seek value
 * @param value Value gotten from the data
 * @return YES on success, NO otherwise
 */
BOOL srk_file_read_dword(NSData *data, size_t *filePos, uint32_t *value);

/**
 * Read a word-length prefixed string from the file, and proceed
 * the seek value.
 *
 * This function verifies that the string can be read from the buffer.
 *
 * @param data NSData object holding the filedata
 * @param filePos Reference to the file seek value
 * @return NSString containing the string on success, nil otherwise
 */
NSString *srk_file_read_string(NSData *data, size_t *filePos);