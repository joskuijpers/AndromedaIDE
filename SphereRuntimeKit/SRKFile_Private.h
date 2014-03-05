//
//  SRKFile_Private.h
//  Sphere
//
//  Created by Jos Kuijpers on 25/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

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