//
//  SPRJSClass.m
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@import ObjectiveC.runtime;
#import "SPRJSClass.h"

void spr_install_js_lib(L8Runtime *context) {
	Class *classes;
	unsigned int count;

	classes = objc_copyClassList(&count);
	for(unsigned int i = 0; i < count; i++) {
		// Class must conform to the protocol
		if(!class_conformsToProtocol(classes[i], @protocol(SPRJSClass)))
			continue;

		// Install...
		[classes[i] installIntoContext:context];
	}

	free(classes);
}