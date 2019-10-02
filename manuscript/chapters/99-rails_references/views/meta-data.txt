#


Risorse web:

* [MetaTags: a gem to make your Rails application SEO-friendly](https://github.com/kpumuk/meta-tags)




## Open Graph
To turn your web pages into graph objects, you'll need to add Open Graph protocol <meta> tags to your webpages. The tags allow you to specify structured information about your web pages. The more information you provide, the more opportunities your web pages can be surfaced within Facebook today and in the future. Here's an example for a movie page:

set_meta_tags og: {
  title:    'The Rock',
  type:     'video.movie',
  url:      'http://www.imdb.com/title/tt0117500/',
  image:    'http://ia.media-imdb.com/rock.jpg',
  video:    {
    director: 'http://www.imdb.com/name/nm0000881/',
    writer:   ['http://www.imdb.com/name/nm0918711/', 'http://www.imdb.com/name/nm0177018/']
  }
}
# <meta property="og:title" content="The Rock">
# <meta property="og:type" content="video.movie">
# <meta property="og:url" content="http://www.imdb.com/title/tt0117500/">
# <meta property="og:image" content="http://ia.media-imdb.com/rock.jpg">
# <meta property="og:video:director" content="http://www.imdb.com/name/nm0000881/">
# <meta property="og:video:writer" content="http://www.imdb.com/name/nm0918711/">
# <meta property="og:video:writer" content="http://www.imdb.com/name/nm0177018/">


Multiple images declared as an array (look at the _ character):

set_meta_tags og: {
  title:    'Two structured image properties',
  type:     'website',
  url:      'view-source:http://examples.opengraphprotocol.us/image-array.html',
  image:    [{
    _: 'http://examples.opengraphprotocol.us/media/images/75.png',
    width: 75,
    height: 75,
  },
  {
    _: 'http://examples.opengraphprotocol.us/media/images/50.png',
    width: 50,
    height: 50,
  }]
}
# <meta property="og:title" content="Two structured image properties">
# <meta property="og:type" content="website">
# <meta property="og:url" content="http://examples.opengraphprotocol.us/image-array.html">
# <meta property="og:image" content="http://examples.opengraphprotocol.us/media/images/75.png">
# <meta property="og:image:width" content="75">
# <meta property="og:image:height" content="75">
# <meta property="og:image" content="http://examples.opengraphprotocol.us/media/images/50.png">
# <meta property="og:image:width" content="50">
# <meta property="og:image:height" content="50">


Article meta tags are supported too:

set_meta_tags article: {
  published_time:    '2013-09-17T05:59:00+01:00',
  modified_time:     '2013-09-16T19:08:47+01:00',
  section:           'Article Section',
  tag:               'Article Tag',
}
# <meta property="article:published_time" content="2013-09-17T05:59:00+01:00">
# <meta property="article:modified_time" content="2013-09-16T19:08:47+01:00">
# <meta property="article:section" content="Article Section">
# <meta property="article:tag" content="Article Tag">


Further reading:

* [Open Graph protocol](http://developers.facebook.com/docs/opengraph/)
* [Must-Have Social Meta Tags for Twitter, Google+, Facebook and More](https://moz.com/blog/meta-data-templates-123)




## Twitter Cards

Twitter cards make it possible for you to attach media experiences to Tweets that link to your content. There are 3 card types (summary, photo and player). Here's an example for summary:

set_meta_tags twitter: {
  card: "summary",
  site: "@username"
}
# <meta name="twitter:card" content="summary">
# <meta name="twitter:site" content="@username">


Take in consideration that if you're already using OpenGraph to describe data on your page, it’s easy to generate a Twitter card without duplicating your tags and data. When the Twitter card processor looks for tags on your page, it first checks for the Twitter property, and if not present, falls back to the supported Open Graph property. This allows for both to be defined on the page independently, and minimizes the amount of duplicate markup required to describe your content and experience.

When you need to generate a Twitter Photo card, twitter:image property is a string, while image dimensions are specified using twitter:image:width and twitter:image:height, or a Hash objects in terms of MetaTags gems. There is a special syntax to make this work:

set_meta_tags twitter: {
  card:  "photo",
  image: {
    _:      "http://example.com/1.png",
    width:  100,
    height: 100,
  }
}
# <meta name="twitter:card" content="photo">
# <meta name="twitter:image" content="http://example.com/1.png">
# <meta name="twitter:image:width" content="100">
# <meta name="twitter:image:height" content="100">


Further reading:

* [Twitter Cards Documentation](https://dev.twitter.com/cards/)



