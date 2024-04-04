declare option output:method "xml";
declare option output:indent "yes";

<posts>{
    
    for $row in /posts/row[@PostTypeId='1']
    let $title := $row/@Title
    let $viewCount := xs:integer($row/@ViewCount)
    order by $viewCount descending
    return <post><title>{$title}</title><viewCount>{$viewCount}</viewCount></post>
}</posts>
