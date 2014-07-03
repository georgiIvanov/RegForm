//
//  BaseFormController.m
//  GiveAway
//
//  Created by uBo on 16/05/2014.
//
//

#import "BaseFormController.h"

@interface BaseFormController ()

@end

@implementation BaseFormController

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *titleHeader = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    
    if ( !titleHeader || [titleHeader isEqualToString:@""] ) {
        return nil;
    }
    
    UIView *container = [[UIView alloc] init];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = titleHeader;
    title.textColor = [UIColor colorWithHexValue:@"#818187" alpha:1.0];
    title.font = [UIFont fontWithName:kStandartFontName size:12];
    
    [container addSubview:title];
    
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.bottom.equalTo(@(-6));
    }];
    
    return container;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSString *titleHeader = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    
    if ( !titleHeader || [titleHeader isEqualToString:@""] ) {
        return 0.001;
    }
    
    return 33.5f;
}

@end
