//
//  TableViewController.m
//  n4g
//
//  Created by Josh Wiliwonka on 9/13/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import "TableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "ViewController.h"

@interface TableViewController ()

@property (strong, nonatomic) NSArray *articlesArray;

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ViewController *detailViewController = (ViewController *)segue.destinationViewController;
    detailViewController.articleDetail = [self.articlesArray objectAtIndex:indexPath.row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self articlesRequest];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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

-(void)articlesRequest{
    NSURL *url = [NSURL URLWithString:@"http://api.n4g.samiulhuq.com/articles"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking async request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        
        self.articlesArray = [responseObject objectForKey:@"articles"];
        
        NSLog(@"The Array: %@", self.articlesArray);
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.articlesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    
    NSDictionary *tempDictionary = [self.articlesArray objectAtIndex:indexPath.row];
    
    //Add article title to each cell
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    UILabel *articleTitle = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 220, 35)];
        articleTitle.tag = 69;
    [cell addSubview:articleTitle];
    
    //cell.textLabel.text = [tempDictionary objectForKey:@"title"];
    
        UIImageView *comment_icon = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 220, 35)];
        comment_icon.tag = 52;
        [cell.contentView addSubview:comment_icon];
        
       
    //Add article description to each cell
    
    UILabel *articleDescription = [[UILabel alloc] initWithFrame:CGRectMake(76, 20, 220, 35)];
            articleDescription.tag = 12;
    [cell addSubview:articleDescription];
    //cell.detailTextLabel.text = [tempDictionary objectForKey:@"description"];

    
    
    
    /*NSString *comments = [tempDictionary objectForKey:@"comments"];
    UILabel *numOfComments = [[UILabel alloc] initWithFrame:CGRectMake(80, 58, 10, 10)];
    numOfComments.text = comments;
    [numOfComments setFont:[UIFont systemFontOfSize: 7]];
    numOfComments.textColor = [UIColor grayColor];
    [cell addSubview:numOfComments];*/

    
    }
    //set title
    UILabel *articleTitle = (UILabel*)[cell.contentView viewWithTag:69];
    [articleTitle setText: [tempDictionary objectForKey:@"title"]];
    
    
    //Set image
    NSString *image_url = [tempDictionary objectForKey:@"image_url"];
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,72,72)];
    myImageView.tag = 1;
    [myImageView setImageWithURL:[NSURL URLWithString:image_url]];
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
    [articleDescription setText:[tempDictionary objectForKey:@"description"]];
        // Configure the cell...
    
    return cell;
        
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
