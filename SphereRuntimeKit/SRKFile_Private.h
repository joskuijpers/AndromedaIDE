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
 * @param data data containing the structure
 * @param size size of the structure to read
 * @param filePos Pointer to the seek position store
 * @return Pointer to the data or NULL when no data enough
 */
void *srk_file_read_struct(NSData *data,
								   size_t size,
								   size_t *filePos);

BOOL srk_file_read_byte(NSData *data, size_t *filePos, uint8_t *value);
BOOL srk_file_read_word(NSData *data, size_t *filePos, uint16_t *value);
BOOL srk_file_read_dword(NSData *data, size_t *filePos, uint32_t *value);
NSString *srk_file_read_string(NSData *data, size_t *filePos);