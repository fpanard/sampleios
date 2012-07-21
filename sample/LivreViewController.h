//
//  LivreViewController.h
//  Table
//
//  Created by François PANARD on 02/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LivreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (id)initWithLivre:(NSArray *)livresArray rayon:(NSString *)rayonName;
@end
