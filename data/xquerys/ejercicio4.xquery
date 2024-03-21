let $topTags :=
    let $allTags := //row/@Tags
    let $distinctTags := distinct-values(tokenize($allTags, '&lt;|&gt;'))
    let $tagCounts := for $tag in $distinctTags
                      return count($allTags[contains(., $tag)])
    let $tagCountsSorted := sort($tagCounts, 'descending')
    return subsequence($distinctTags, 1, 10)

return
<topQuestions>
{
    for $question in //row
    where some $tag in $topTags satisfies contains($question/@Tags, $tag)
    let $views := xs:integer($question/@ViewCount)
    order by $views descending
    return $question[position() <= 100]
}
</topQuestions>
