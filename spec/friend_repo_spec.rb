 RSpec.describe FriendRepo do 
  describe '.get_friends' do 
    it 'should get a list of friends ids from steam api' do 
      VCR.use_cassette('get_user_friends') do
        user = '76561197973955570'

        hash = FriendRepo.get_friends(user)

        expect(hash[:success?]).to be true
        expect(hash[:friends]).to include("76561197995163285")
      end
    end
  end
  describe '.save_friends' do 
    it 'should save a list of friends connected to user' do 
      VCR.use_cassette('save_user_friends10') do
        user = User.create(:steam_id_64 => 76561197973955570)
        friends = ["76561197964282412", "76561197970623174", "76561197972533015", "76561197974442188", "76561197976572599", "76561197978638574", "76561197988762001", "76561197992028918", "76561197995163285", "76561198001830898", "76561198002572492", "76561198005129680", "76561198008887970", "76561198009220906", "76561198026508218", "76561198044209292", "76561198047040418", "76561198050505998", "76561198051831682", "76561198053159586", "76561198056433829", "76561198059279901", "76561198062010300", "76561198062797493", "76561198072218295", "76561198122509603", "76561198129078372", "76561198134716933", "76561198139251454"]

        hash = FriendRepo.save_friends(user, friends)

        expect(hash[:success?]).to be true
        expect(hash[:friends].last.id).to_not be nil
      end
    end
  end
  describe '.get_friend_games' do 
    it 'should save a list of games connected to friend' do 
      VCR.use_cassette('get_friend_games') do
        friends = []
        friend_ids = ["76561197964282412", "76561197970623174", "76561197972533015"]
        friend_ids.each do |friend|
          friends.push(Friend.create(:steam_id_64 => friend))
        end

        hash = FriendRepo.get_friends_games(friends)

        expect(hash[:success?]).to be true
        expect(hash[:friends_games]).to_not be nil
      end
    end
  end

  describe '.get_friend_games' do 
    it 'should save a list of games connected to friend when one of the friends is private' do 
      VCR.use_cassette('get_friend_games_when_private') do
        friends = []
        friend_ids = ["76561197964282412", "76561197970623174", "76561198002572492"] 
        friend_ids.each do |friend|
          friends.push(Friend.create(:steam_id_64 => friend))
        end

        hash = FriendRepo.get_friends_games(friends)

        expect(hash[:success?]).to be true
        expect(hash[:friends_games]).to_not be nil
      end
    end
  end
  
  describe 'compare_friends_games' do 
    it 'should get a list of friends ids from steam api' do 
      VCR.use_cassette('compare_user_friends') do
        user_games = [3920,
 240,
 4000,
 2620,
 2630,
 2640,
 320,
 340,
 400,
 12900,
 2700,
 20,
 50,
 70,
 130,
 220,
 280,
 360,
 380,
 420,
 20900,
 12210,
 18500,
 17470,
 24740,
 1250,
 35420,
 36000,
 24800,
 10180,
 10190,
 23490,
 32440,
 550,
 223530,
 24960,
 8190,
 35140,
 33900,
 33930,
 219540,
 17410,
 70300,
 18400,
 21130,
 21000,
 4540,
 44320,
 620,
 45760,
 105600,
 20920,
 7600,
 6000,
 6020,
 6030,
 6060,
 32350,
 32370,
 32380,
 32390,
 32400,
 32420,
 32430,
 32470,
 32500,
 8980,
 107310,
 28050,
 63000,
 8930,
 113200,
 55230,
 115100,
 102600,
 72850,
 22380,
 115110,
 207650,
 207490,
 208600,
 3900,
 3990,
 8800,
 16810,
 34440,
 34450,
 34460,
 212680,
 108800,
 3830,
 48000,
 57300,
 204060,
 107100,
 26800,
 40800,
 209830,
 12750,
 730,
 202170,
 204120,
 213330,
 215510,
 207890,
 20820,
 41500,
 107200,
 107800,
 108500,
 65300,
 49520,
 204300,
 200260,
 209540,
 206440,
 220780,
 202970,
 202990,
 212910,
 200710,
 204360,
 18450,
 18460,
 18420,
 205100,
 205790,
 214560,
 219640,
 232210,
 219150,
 223220,
 218740,
 4920,
 201790,
 4560,
 9340,
 20540,
 43110,
 50620,
 55110,
 228200,
 214510,
 80300,
 4570,
 113020,
 200900,
 35720,
 212480,
 227300,
 219890,
 218230,
 218170,
 230980,
 224580,
 225260,
 218060,
 203160,
 221380,
 227080,
 233450,
 220160,
 233720,
 3910,
 224760,
 233230,
 234190,
 220200,
 222730,
 235820,
 209160,
 209170,
 236090,
 231160,
 242920,
 242110,
 201420,
 237530,
 214770,
 247370,
 244070,
 239030,
 242550,
 231040,
 218620,
 47790,
 47830,
 209000,
 206420,
 214550,
 253690,
 3370,
 3390,
 3480,
 3600,
 78000,
 3540,
 3590,
 3620,
 221910,
 254440,
 244090,
 267530,
 7670,
 8850,
 8870,
 224480,
 265930,
 285160,
 219740,
 35450,
 236830,
 301520,
 241930,
 107410] 
      friends_games = {76561197964282412=>
  [10,
   20,
   30,
   40,
   50,
   60,
   70,
   130,
   80,
   100,
   220,
   240,
   320,
   340,
   1300,
   1309,
   1313,
   4000,
   3200,
   6860,
   6510,
   2280,
   2290,
   2300,
   9050,
   9070,
   9160,
   380,
   400,
   420,
   3270,
   12900,
   15100,
   20900,
   500,
   17460,
   17470,
   24740,
   1250,
   35420,
   22330,
   6060,
   32370,
   17450,
   11450,
   12710,
   12810,
   45700,
   24980,
   33230,
   43110,
   13560,
   13570,
   13580,
   33220,
   32470,
   42650,
   17410,
   2800,
   2810,
   2820,
   2840,
   2850,
   201310,
   12210,
   12220,
   40800,
   6330,
   6850,
   6870,
   6880,
   6900,
   6910,
   6920,
   6980,
   7000,
   7010,
   7020,
   7060,
   8000,
   8080,
   8100,
   8140,
   8160,
   8170,
   8190,
   23300,
   23310,
   23380,
   23390,
   28000,
   34600,
   35000,
   35070,
   35130,
   35140,
   39110,
   40100,
   43000,
   2760,
   47780,
   21100,
   42910,
   620,
   34330,
   48190,
   28050,
   105600,
   20920,
   104600,
   13500,
   13530,
   13600,
   19980,
   33320,
   91700,
   21090,
   21110,
   21120,
   16450,
   48000,
   32800,
   107100,
   17710,
   9350,
   9420,
   113200,
   34270,
   71340,
   201280,
   201870,
   39160,
   39190,
   39200,
   72850,
   55230,
   200900,
   98800,
   104700,
   207320,
   207490,
   102500,
   207610,
   205350,
   104900,
   200260,
   108800,
   207350,
   209080,
   213120,
   212680,
   49520,
   205790,
   219640,
   232210,
   218680,
   7670,
   8870,
   200510,
   223220,
   211400,
   4920,
   113020,
   34190,
   71250,
   200940,
   202530,
   203650,
   213610,
   209540,
   219890,
   99900,
   212070,
   218230,
   230410,
   231060,
   286080,
   39120,
   209870,
   1500,
   1510,
   1520,
   1530,
   233450,
   225140,
   220200,
   236090,
   231160,
   233250,
   39140,
   244850,
   246700,
   214770,
   225180,
   248820,
   206420,
   234670,
   233130,
   255520,
   257350,
   213670,
   221910,
   261030,
   265930,
   266430,
   211820,
   202170,
   8930,
   235460,
   271290,
   272510,
   273070,
   256290,
   304030,
   240760,
   259130,
   244630,
   17580,
   65980,
   107410],
 76561197970623174=>
  [10,
   20,
   30,
   40,
   50,
   60,
   70,
   80,
   100,
   130,
   220,
   240,
   280,
   300,
   320,
   340,
   360,
   380,
   400,
   420,
   7940,
   7670,
   22330,
   32370,
   22370,
   8930,
   22380,
   12210,
   12220,
   105600,
   20920,
   72850,
   730,
   200510,
   49520,
   208480,
   220240,
   17460,
   24980,
   212500,
   218230,
   8870,
   227300,
   41900,
   240760,
   259130,
   550,
   43160,
   107410]}

        hash = FriendRepo.compare_friends_games(friends_games, user_games)

        expect(hash[:success?]).to be true
        expect(hash[:games]).to include(105600)
      end
    end
  end

end