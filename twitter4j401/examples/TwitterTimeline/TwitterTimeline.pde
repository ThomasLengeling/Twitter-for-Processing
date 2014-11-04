import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;

import java.util.List;
import java.util.Iterator;

ConfigurationBuilder   cb;
Query query;
Twitter twitter;

ArrayList<UserCustom> twittersList;
Timer             time;

//Number twitters per search
int numberSearch = 10;

PFont font;
int   fontSize = 14;

String screenName;

void setup() {
  size(670, 650);
  background(0);
  smooth(4);

  //FONT
  font = createFont("NexaLight-16.vlw", fontSize, true);
  textFont(font, fontSize);

  //You can only search once every 1 minute
  time = new Timer(70000); //1 min with 10 secs

  //Acreditacion
  cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("");
  cb.setOAuthConsumerSecret("");
  cb.setOAuthAccessToken("");
  cb.setOAuthAccessTokenSecret("");


  //Make the twitter object and prepare the query
  twitter = new TwitterFactory(cb.build()).getInstance();

  //SEARCH
  twittersList = queryTwitter(numberSearch);
}

void draw() {
  background(255);
  
  textFont(font, fontSize*1.6);
  text(screenName, 40, 40);
  text("'s home timeline", textWidth(screenName) + 3 + 40, 40);
  //draw twitters
  
  textFont(font, fontSize);
  drawTwitters(twittersList);

  if (time.isDone()) {
    twittersList = queryTwitter(numberSearch);
    time.reset();
  }

  text(time.getCurrentTime(), width - fontSize*8, 40);

  time.update();
}

void drawTwitters(ArrayList<UserCustom> tw) {
  Iterator<UserCustom> it = tw.iterator();
  int i = 0;

  while (it.hasNext ()) {
    UserCustom usr = it.next();
    usr.draw( 30, 70 + i*fontSize*4);
    i++;
  }
}

ArrayList<UserCustom> queryTwitter(int nSearch) {
  ArrayList<UserCustom> twitt = new ArrayList<UserCustom>();

  try 
  {
    println("10 Twitter timeline");
    User user = twitter.verifyCredentials();
    screenName = "@"+user.getScreenName();

    Paging paging = new Paging(1, 10);
    List<Status> statuses = twitter.getHomeTimeline(paging);

    for (Status status : statuses) {
      String usr = "@"+status.getUser().getName();
      String msg =  status.getText();
      twitt.add(new UserCustom(usr, msg, fontSize));
    }
  }
  catch(TwitterException te) {
    println("Couldn't connect: " + te);
  }

  return twitt;
}

