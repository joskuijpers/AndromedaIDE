//
//  NSString+Hashing.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "NSString+Hashing.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Hashing)

- (NSString *)stringByHashingWithMethod:(JSXStringHashMethod)method
{
	switch(method) {
		case JSXStringMD5Hash:
			return [NSString md5Digest:self];
		case JSXStringSHA1Hash:
			return [NSString sha1Digest:self];
		default:
			return nil;
	}
}

+ (NSString *)md5Digest:(NSString *)source
{
	NSString *digest = nil;
	unsigned char md5[CC_MD5_DIGEST_LENGTH];
	const char *buffer;
	
	if((buffer = [source UTF8String])) {
		bzero(md5, CC_MD5_DIGEST_LENGTH);
		CC_MD5(buffer, (CC_LONG)strlen(buffer), md5);
		digest = [NSString stringWithFormat:@"%08X%08X%08X%08X",
				  *((unsigned int *)&md5[0]),
				  *((unsigned int *)&md5[4]),
				  *((unsigned int *)&md5[8]),
				  *((unsigned int *)&md5[12])];
	}
	
	return digest;
}

+ (NSString *)sha1Digest:(NSString *)source
{
	NSString *digest = nil;
	unsigned char sha1[CC_SHA1_DIGEST_LENGTH];
	const char *buffer;
	
	if((buffer = [source UTF8String])) {
		bzero(sha1, CC_SHA1_DIGEST_LENGTH);
		CC_SHA1(buffer, (CC_LONG)strlen(buffer), sha1);
		digest = [NSString stringWithFormat:@"%08X%08X%08X%08X%08X",
				  *((unsigned int *)&sha1[0]),
				  *((unsigned int *)&sha1[4]),
				  *((unsigned int *)&sha1[8]),
				  *((unsigned int *)&sha1[12]),
				  *((unsigned int *)&sha1[16])];
	}
	
	return digest;
}

@end
