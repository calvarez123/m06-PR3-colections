declare option output:method "xml";
declare option output:indent "yes";

<posts>{
    for $row in subsequence(/posts/row, 1, 1)
    let $title := $row/@Title
    let $viewCount := xs:integer($row/@ViewCount)
    order by $viewCount descending
    return <post>{$title}{$viewCount}</post>
}</posts>
