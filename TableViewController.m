//
//  TableViewController.m
//  n4g
//
//  Created by Josh Wiliwonka on 9/13/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import "TableViewController.h"
#import "UIImageView+AFNetworking.h"
#import <UIViewController+ScrollingNavbar.h>
#import "AFNetworking.h"
#import "ViewController.h"
#import "Articles.h"

const int kLoadingCellTag = 123;

@interface TableViewController ()

@property (nonatomic, retain) NSMutableArray *articlesArray;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Pass article properties to detail view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ViewController *detailViewController = (ViewController *)segue.destinationViewController;
    detailViewController.articleDetail = [self.articlesArray objectAtIndex:indexPath.row];
    NSLog(@"Detail view is : %@", detailViewController.articleDetail);
}

//Start animating indicator before table loads
-(void)viewWillAppear:(BOOL) animated {
    
    [super viewWillAppear:animated];
    [self.activity startAnimating];
    
}

/*-(void)viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
    [self.activity performSelector:@selector(stopAnimating) withObject:nil];
}*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //AMScrollingNavBar
    [self setTitle:@"N4G"];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.039 green:0.445 blue:0.700 alpha:1.000]];
    [self followScrollView: self.view];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(articlesRequest)
                  forControlEvents:UIControlEventValueChanged];
    
    self.articlesArray = [NSMutableArray array];
    _currentPage = 1;
    [self articlesRequest];
    UIActivityIndicatorView *actInd =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //Initialize the refresh control
    
    actInd.color = [UIColor blackColor];
    [actInd setCenter:self.view.center];
    
    self.activity = actInd;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    
    NSArray *actionButtonItems = @[shareItem, cameraItem];
    //self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    //Add UIActivity indicator to view
    [self.view addSubview:self.activity];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

-(void)articlesRequest{
    
    NSString *urlString;
    NSURL *url;
    
    //If pull-to-refresh is used, set current page to 1
    if ([self.refreshControl isRefreshing]){
        _currentPage = 1;
    }
    
    
    if (_currentPage >= 2){
        urlString = [NSString stringWithFormat:@"http://api.n4g.samiulhuq.com/articles/page/%ld", (long)_currentPage];
        url = [NSURL URLWithString:urlString];
    
    } else {
        urlString = @"http://api.n4g.samiulhuq.com/articles";
        url = [NSURL URLWithString:urlString];
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking async request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        _totalPages = 20;
        
        //Don't append to array if pull-to-refresh is being used
        if ([self.refreshControl isRefreshing]){
            [self.articlesArray removeAllObjects];
            
        }
        
        for (id articleDictionary in [responseObject objectForKey:@"articles"]){
            Articles *article = [[Articles alloc] initWithDictionary:articleDictionary];
            
                [self.articlesArray addObject:article];
            
        }
        //self.articlesArray = [responseObject objectForKey:@"articles"];
        
        NSLog(@"The Array: %@", self.articlesArray);
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
#warning Potentially incomplete method implementation.
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
#warning Incomplete method implementation.
    //If total pages, then don't show activity indicator
    if (_currentPage < _totalPages){
        return self.articlesArray.count + 1;
    }
    return [self.articlesArray count];
}

- (UITableViewCell *)articleCellForIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    Articles *article = [self.articlesArray objectAtIndex:indexPath.row];

    
    //Add article title to each cell
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //set article title
        UILabel *articleTitle = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 220, 35)];
        articleTitle.tag = 69;
        [cell addSubview:articleTitle];
        
        //set message vector
        UIImageView *comment_icon = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 220, 35)];
        comment_icon.tag = 52;
        [cell.contentView addSubview:comment_icon];
        
        //init article description
        UILabel *articleDescription = [[UILabel alloc] initWithFrame:CGRectMake(76, 20, 220, 35)];
        articleDescription.tag = 12;
        [cell addSubview:articleDescription];
        
        //init article comments #
        UILabel *numOfComments = [[UILabel alloc] initWithFrame:CGRectMake(80, 58, 10, 10)];
        numOfComments.tag = 9;
        [cell addSubview:numOfComments];
        
        //init article temperature
        UILabel *temperature = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 8, 8)];
        temperature.tag = 15;
        [cell.contentView addSubview:temperature];
        
        
    }
    
    //set user and time posted
    NSString *timePosted = [[NSString alloc] initWithFormat :@"%@ %@",article.posted, article.user];
    UILabel *posted = (UILabel*)[cell.contentView viewWithTag:16];
    [posted setText: timePosted];
    
    //set comments
    UILabel *numOfComments = (UILabel*)[cell.contentView viewWithTag:9];
    [numOfComments setText: article.numOfComments];
    
    
    //set title
    UILabel *articleTitle = (UILabel*)[cell.contentView viewWithTag:69];
    [articleTitle setText: article.articleTitle];
    
    
    //Set image
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,12.5,72,72)];
    myImageView.tag = 1;
    [myImageView setImageWithURL:[NSURL URLWithString:article.imageURL]];
    [cell.contentView addSubview:myImageView];
    
    //Add message_icon
    UIImageView *comment_icon = (UIImageView*)[cell.contentView viewWithTag:52];
    UIImage *image = [UIImage imageNamed:@"message_icon"];
    [comment_icon setImage:image];
    
    //set temp icon
    UIImageView *temperatureIcon = (UIImageView*)[cell.contentView viewWithTag:53];
    UIImage *icon = [UIImage imageNamed:@"low_temperature"];
    [temperatureIcon setImage:icon];
    
    //set description
    UILabel *articleDescription = (UILabel*)[cell.contentView viewWithTag:12];
    [articleDescription setText: article.articleDescription];
   
    [self.activity stopAnimating];
    
    return cell;

}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 26) {
        return 60;
    } else {
        return 92;
    }

}*/

//Put Activity indicator at the end of table
-(UITableViewCell *)loadingCell{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = cell.center;
    [cell addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    cell.tag = kLoadingCellTag;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (cell.tag == kLoadingCellTag){
        _currentPage++;
        [self articlesRequest];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.articlesArray.count){
        return [self articleCellForIndexPath:indexPath];
    } else {
        return [self loadingCell];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
