/* Copyright (c) 2011 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLAnalyticsAccount.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google Analytics API (analytics/v3)
// Description:
//   View and manage your Google Analytics data
// Documentation:
//   http://code.google.com/apis/analytics
// Classes:
//   GTLAnalyticsAccount (0 custom class methods, 7 custom properties)
//   GTLAnalyticsAccountChildLink (0 custom class methods, 2 custom properties)

#import "GTLAnalyticsAccount.h"

// ----------------------------------------------------------------------------
//
//   GTLAnalyticsAccount
//

@implementation GTLAnalyticsAccount
@dynamic childLink, created, identifier, kind, name, selfLink, updated;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"analytics#account"];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsAccountChildLink
//

@implementation GTLAnalyticsAccountChildLink
@dynamic href, type;
@end
