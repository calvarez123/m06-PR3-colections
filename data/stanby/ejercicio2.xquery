declare option output:method "xml";
declare option output:indent "yes";

<top_users>{
    for $user in distinct-values(/posts/row/@OwnerUserId)
    let $question_count := count(/posts/row[@OwnerUserId = $user and @PostTypeId = "1"])
    order by $question_count descending
    return <user id="{$user}" question_count="{$question_count}"/>
}</top_users>[position() <= 1]
