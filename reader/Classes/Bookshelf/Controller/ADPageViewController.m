//
//  ADPageViewController.m
//  reader
//
//  Created by beequick on 2017/8/4.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADPageViewController.h"
#import "ADContentViewController.h"
#import "ADChapterContentModel.h"

@interface ADPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *readViewController;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ADChapterContentModel *model;
@end

@implementation ADPageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self addChildViewController:self.readViewController];
    [self.view addSubview:_readViewController.view];
    
    
}

- (void)loadData{
    self.model = [[ADChapterContentModel alloc] init];
    self.model.content =  @"鹰国标准时间，晨时七点三十分。\n帝国首相穆夫在国家电视台，发表对全鹰国的电视讲话。电视中，穆夫一身正装，在那张放着小型鹰国旗帜的红木桌前，面对着镜头。\n他那张纹路分明的脸上，透露出一股沧桑，又有几分欣慰。这位首相在位六年，在四年一届的首相轮替中，他在女王和民众议会的支持下连任了两届，不过是短短六年的时间，如果有人找到这位首相参加竞选时当初风华正茂的模样，一定不会相信眼前这个头发斑白，眼窝因为长久熬夜而深陷，只是眼神更加睿智矍铄的男人，就是当年那位被帝国无数女子封为模样标准，最具魅力大叔的男人。\n在穆夫执政的这六年里，正是帝国命途多舛的非常时刻，组建战时内阁，鹰国前所未有的面临全面战争，他身上担负着重大的责任和使命。这一切国家民族的压力在这个中年男子的脸上雕刻出了非常深刻而隽永的痕迹。\n他原本不会为任何事物打动的沧桑面容，在今天的电视讲话面前，终于有了一种长久压力得到了一丝宣泄，如释重负的轻松。\n他扬起了眉宇，听到自己骄傲的声音，面对镜头响起。\n“今天，是一个美丽的日子，我将藉此，向大家发表演说，给大家带来一个消息。\n不久之前，翎卫军队的独孤和铁弗，率领舰队，用暴雨般的能量射线和炸弹进攻了西玛轨道圈。得到这个消息，帝国震动，亿万同胞为之动容。我去过西玛轨道圈，那里是一个人类自造殖民圈的奇迹，那里的人民，生活和行星都市一般无二，孩童在那里玩耍，少女们在那里动听的欢笑，无忧无虑的恋爱和成长……但是，就是那么突如其来，他们用血肉之躯，承受了翎卫舰队的巨舰大炮轰炸，遭到了翎卫军钢铁机甲的碾压，敌人穷凶极恶，残忍至极的展开了屠杀。目的正是和西庞人联合，要对我帝国人民进行侵略，从而进一步统治和奴役这个饱经风霜的国度。\n为了抗击侵略，我们的舰队前往了流明星域日落峡空间通道，对翎卫军展开了阻击……现在，我能以难以抑制的振奋心情，向大家宣告。\n日落峡之战——大捷！\n我们的舰队和流明星域集结的反抗军战舰将士们，用他们的鲜血，艰难而又勇敢的捍卫了我们的国土，以牺牲的代价，坚守了我们的尊严！\n日落峡战役，翎卫舰队溃败！我们生擒回了西玛轨道圈杀人如麻的战争暴徒铁弗！他将接受帝国全体人民的审判！这是我们抗击侵略者的一场来之不易的伟大胜利！\n我们将击败所有环伺四周觊觎国土的敌人！并最终击败西庞人，保卫我们的家园！让自由民族，自由人民的公义，在这宇宙闪烁！生命一息尚存，我们都将战斗不止！\n至此，为此役为帝国付出鲜血和生命，却带给我们胜利的勇士们，致敬！”\n清晨第一缕晨曦映照的住宅楼里，叫伍特的男子只是首都星无数中年居家男人的一员，今天是周末，他一如既往的在清晨的窗台喝一杯老婆泡好的咖啡，用着两块粗糙面包叠放在一起简单的早餐。很多事情都改变了，以往面包片上会有一块金黄色酥脆的煎蛋，如今煎蛋没有了，咖啡也多了酸涩的味道，没有了以往的新鲜。\n唯有一件事情没有变，那就是伍特每天雷打不动的收看晨时新闻。\n鹰国和西庞人的战争打倒了哪一步了？他并不知道，他只知道战争方方面面影响到了人们的生活，老婆开始抱怨物价涨了，他每月的工资开始急速缩水，孩子的学校里人心惶惶，对战事的关注成为了人们密不可分的生活一部分。哪怕是小孩都不例外。\n据说旁边隔壁的老王的儿子被下达了阵亡通知单，他儿子是正规军校毕业，毕业后就成为太空军某师团一员，参与了费远星的保卫战。帝国的收尸人将遗体送到小区的时候，他们听到了帝国国歌《勇敢者》奏响的声音。\n后来老王的儿子被埋葬在了后山的墓地，小区里的很多邻居有人都前往参加了吊唁。而隔壁的街区里，据说也有两位太空军将士的家属，同样举办了葬礼。\n年轻的人们正在为保卫家园的战争前仆后继死去。而伍特最关注孩子们，如果这场战争，鹰国战败，孩子们，也就无所谓还有光明的未来了。\n此时此刻，晨间新闻里就这么传来了首相的电视讲话。\n“日落峡之战，大捷！”\n伍特几乎是在听到这个消息的一瞬间，就从座位上“噌！”的站了起来，这个时候，他旁边正在干活的妻子，已经丢下了拖把，伸出手掩住了嘴巴。\n帝国的局势让人忧心忡忡，哪怕是平时对军事和战争并不在意，只关心结果的家庭妇女们，从每一次男人带回家购买力衰减的工资，从每一场捕风捉影的前线谣言下突然被哄抢物资的超市，从人们在惶恐下，街区越来越多的治安问题里，都感受到了战争的压迫力。\n而此时此刻，一场“大捷！”的通告，足以让伍特的老婆突然涌出热泪！\n压抑的是生活，但罪魁祸首却是这场引爆人类社会的战争。\n“我_操！我_操！我_操！”伍特猛地爆发出属于中年男人的怒吼，不停用力虚空击拳，整个人都浸入一种鼓舞雀跃的状态，他扑过去抱着自己的孩子，猛地亲了好几十口，可怜的小家伙捂着脸蛋，噙着眼泪不明就里的看着疯起来的父亲。\n然后他激动兴奋的坐进书房，忙不迭打开电脑，看到网络一片沸反盈天，很明显，首相的这场讲话，正疯狂的传遍各大星区。\n伍特猛地被一股喧杂的声浪吸引，扭开头，那是小区其他的住宅楼，正由远及近的传来阵阵脚跺地捶桌的声音。\n然而更吸引伍特的是远处，那些一条条高耸入云霄重重叠叠繁密复杂的陆航车轨道线，每一条都因为高峰期而排行了无数车辆。\n此时此刻，这些车辆，停下了流淌，然后，是整齐划一的鸣笛。这鸣笛声很快汇合成一片宏大的声响，在这座都市里，响彻回荡起来，让每一个听到的人都背脊血液上涌。\n不少的车辆打开门，有人下来，无论是商务车，还是家用车，下车来的人们无论男女，都互相就近拥抱，激动的挥舞手上的事物，和对面车道停下的车下来的人相互遥呼庆祝。无数交错纵横的车道，成为了人群就地庆贺一场激动人心消息欢脱的海洋。\n这样的海洋中，不知名的两个单身男女刚拥抱在一起，在蹦蹦跳跳后，羞赧的发现了不妥慌忙分开，却彼此尴尬得无所适从，片刻后，看到女子美丽羞涩的侧颜，男子头脑发热，大胆探身上前，用颤抖的手搂住其腰肢，对准那诱人的红色樱唇，深深的吻了上去……而后，女孩也就热烈回应了起来。\n******\n晨时八点，副首相艾威走出了首相办公室，又通过了首相和女王在王宫连线的授权，进入了下一间屋子，他接到的任务是和几位内阁幕僚准备一下，即将在接下来进入新闻房，公开表达战时内阁对大捷后一些计划的展望和调整。\n艾威几乎是半夜就被紧急电话催醒，星夜从家里赶到唐宁街，一直忙碌到此时。但此刻他反倒没有半点疲惫，而是精神抖擞。\n在这间办公室中，可以通过身边秘书的携带平板，看到外部的新闻报道。帝国国家电视台，此刻正在直播各地听闻这个消息后的反应。记者们深入到人群之中，采访公众。\n“太了不起了……我们一直不知道“复仇女神”计划，之前还一直在苛责内阁和军方，直至今天，我们才知道他们一直在默默的做着这些事！”\n“请让我们给此战的英雄们敬个礼吧！我们已经迫不及待想要知道日落峡之战的详细细节了！”\n“我想，很多年后，人们都记得“日落之日”！是的，这是我们取的名字，日落峡的战役，翎卫军队溃败的这个时刻，这是非常，非常激动人心的礼物！”记者镜头前的女子掌心捂着心口，又伸出去摆了摆手，语声传来难以掩饰的激动，“……我完全不知道，应该用什么样的言语来形容这一刻……”\n艾威收回目光，有些感慨，“相比起西庞人投入龙门七将后，在前线跟我们造成的威胁和压迫，人们更对这场对翎卫的复仇反应更为激烈啊……那是因为，对方身负了我们的血仇啊……”\n“副相！内部信报。”一名黑西装的政务人员来到艾威面前，递上了一份仅供极少级别的人翻阅的内部信件。\n艾威沉静的翻看这份报告，目光在上面缓慢游弋，最后，他合上了报告，对身边注目着他的幕僚官员们，道，“我们正在动用手头上目前可以调用的破译能力，尝试着从那些俘获的翎卫舰上逆向破解到对方的空间通道密码……试试看，能否把那艘船，给营救回来！”\n*******\n相比起帝国亿万民众们享受复仇女神计划带来的惊艳大捷，首都星的犁田区那座林家的城堡，却显得有些沉寂。\n今早的时候，有唐宁街的高官乘坐车辆到达了这里，伯爵林威和一干脸色慌张的家族长老们在内阁的高级议员口述中得到了什么消息。\n夫人宁清脸色苍白，被林威给扶住了，小儿子林昊脸上表现出难以置信的神色，而林威身旁的那些家族爵士长者们，则是人人显得情绪低落，有的人有一丝不甘的对高级议员询问着什么，似乎想要努力确认真相。或者确认那个人是否有归来的希望。\n那些议员在踌躇之后，终究是为难的表示无可奉告，但说了一些安慰的话语。譬如内阁和军方正在想办法，一有任何消息，就会通知这个家族。\n最终那些传话的高官还是告辞离开了，一群人站在古堡面前，看着那辆黑色车辆走远，也长久没有挪动步子，仿佛是在期待着，那辆车会突然折返回来，推翻之前告诉他们的一切消息。\n伯爵林威站在那里，片刻后，连续说道，“好！”“好！”“好！”\n第一个“好！”脱口而出的时候，是一种爆破性，带着骄傲和男人血气的语调。\n第二个“好！”，则是转为温和，期许的语调。\n而第三个“好！”，则是一丝低落的，悲伤地，略显难过而苍凉的语气。\n随即他扶着自己的夫人，走回了城堡，他们现在毫无办法，面对遥远的星海，人力显得是那样无助渺小……唯有静待。\n那些家族的长者爵士们，都垂头丧气，狠狠一跺脚，焦急无奈沮丧哀莫忧虑……最终都演变成一种唯有祈望奇迹出现的眼巴巴企盼。\n家族很沉默，这座古堡似乎都丧失了活力，只沉浸在一股愤怒担虑无助祈求的氛围中。\n只是在城堡三楼的那个房间窗台，那个叫林薇的女子靠着窗沿。手上捏着那份日落峡战役的大体报告，面对着庄园外这片秋凋冬枯的红枫。\n看到那些片片叶旋落的世界，她长久的凝望着，似乎要在这里枯坐着，等待枫树花开时节的到来……";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index{
    
   
    ADContentViewController *page = [[ADContentViewController alloc] init];
    page.index = index;
    page.content = [self.model getStringWith:index];
    return page;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController{
    return [self.dataSource indexOfObject:viewController];
}

#pragma mark - delegate && datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index --;
    return [self.dataSource objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index <= ([self.dataSource count] - 1)) {
        return [self.dataSource objectAtIndex:index];
    }else{
        UIViewController *viewController = [self viewControllerAtIndex:index];
        [self.dataSource addObject:viewController];
        return viewController;
    }
    
}

- (UIPageViewController *)readViewController{
    if (!_readViewController) {
        //    初始化pageController
        /**
         *  @author LQQ, 15-12-26 18:12:44
         *
         *  UIPageViewControllerSpineLocationMin 单页显示
         
         UIPageViewControllerSpineLocationMid 双页显示
         */
        _readViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionSpineLocationKey:@0,UIPageViewControllerOptionInterPageSpacingKey:@10}];
        _readViewController.dataSource = self;
        _readViewController.delegate = self;
        UIViewController *page_fir = [self viewControllerAtIndex:0];
        NSArray *array = [NSArray arrayWithObjects:page_fir, nil];
        [_readViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
            NSLog(@"s");
        }];
        [self.dataSource addObject:page_fir];
        _readViewController.view.frame = self.view.bounds;
        
    }
    return _readViewController;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
