import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;

import java.util.List;
import java.util.Iterator;

ConfigurationBuilder   cb;
Query query;
Twitter twitter;

ArrayList<User> twittersList;
Timer             time;

//Number twitters per search
int numberSearch = 10;

PFont font;
int   fontSize = 14;

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
  background(42);

  //draw twitters
  drawTwitters(twittersList);

  if (time.isDone()) {
    twittersList = queryTwitter(numberSearch);
    time.reset();
  }
  
  text(time.getCurrentTime(), 20, 30);

  time.update();
}

void drawTwitters(ArrayList<User> tw) {
  Iterator<User> it = tw.iterator();
  int i = 0;

  while (it.hasNext ()) {
    User usr = it.next();
    usr.draw( 30, 60 + i*fontSize*4);
    i++;
  }
}

ArrayList<User> queryTwitter(int nSearch) {
  ArrayList<User> twitt = new ArrayList<User>();

  query = new Query("#processing");
  query.setCount(nSearch);
  try {
    QueryResult result = twitter.search(query);
    List<Status> tweets = result.getTweets();
    println("New Tweet : ");
    for (Status tw : tweets) {
      String msg = tw.getText();
      String usr = "@"+tw.getUser().getScreenName()+": ";
      twitt.add(new User(usr, msg, fontSize));
    }
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  }

  return twitt;
}

