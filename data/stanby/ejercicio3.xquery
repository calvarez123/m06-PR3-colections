declare option output:method "xml";
declare option output:indent "yes";

<tags>{
  let $posts := /posts/row
  let $tags := for $p in $posts
               let $tagString := $p/@Tags
               for $tag in tokenize($tagString, '&lt;|&gt;')
               where string-length($tag) > 0
               return $tag
  let $tagCounts := for $tag in distinct-values($tags)
                    let $count := count($tags[. = $tag])
                    order by $count descending
                    return <tag name="{$tag}" count="{$count}"/>
  return $tagCounts
}</tags>[position() <= 1]