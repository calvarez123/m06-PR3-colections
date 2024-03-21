declare option output:method "xml";
declare option output:indent "yes";

<topTitles>
{
    let $topTitles :=
        for $question in //row
        let $views := xs:integer($question/@ViewCount)
        order by $views descending
        return $question/(@Title)[1]
    return subsequence($topTitles, 1, 100)
}
</topTitles>
