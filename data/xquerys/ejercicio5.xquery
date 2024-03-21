declare option output:method "xml";
declare option output:indent "yes";

let $top_questions :=
    for $row in /rows[@PostTypeId = "1"]
    order by xs:integer($row/@Score) descending
    return $row[position() <= 10]

let $result :=
    for $question in $top_questions
    let $top_answer := 
        for $answer in /rows[@PostTypeId = "2" and @ParentId = $question/@Id]
        order by xs:integer($answer/@Score) descending
        return $answer[1]
    return (
        <question>
            <title>{$question/@Title}</title>
            <body>{$question/@Body}</body>
            <score>{$question/@Score}</score>
            <tags>{$question/@Tags}</tags>
            <top_answer>
                <body>{$top_answer/@Body}</body>
                <score>{$top_answer/@Score}</score>
            </top_answer>
        </question>
    )

return $result
