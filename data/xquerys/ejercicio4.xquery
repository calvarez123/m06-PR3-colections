declare option output:method "xml";
declare option output:indent "yes";

let $topTags :=
  for $post in /posts/row
  let $tagList := tokenize($post/@Tags, '[&gt;&lt;]')
  for $tag in $tagList
  where string-length($tag) > 0
  group by $tag
  order by count($tag) descending
  return $tag

let $topTagNames := $topTags[position() < 11]

let $topPosts :=
  for $post in /posts/row
  where some $tag in $topTagNames satisfies contains(concat('&lt;', $post/@Tags, '&gt;'), concat('&lt;', $tag, '&gt;'))
  order by xs:integer($post/@ViewCount) descending
  return $post[position() <= 100]

return $topPosts
