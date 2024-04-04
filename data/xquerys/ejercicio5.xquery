declare option output:method "xml";
declare option output:indent "yes";

let $topQuestions :=
  for $question in /posts/row[@PostTypeId = 1]
  let $topScore := max(for $score in $question/@Score return xs:integer($score))
  where xs:integer($question/@Score) = $topScore
  return $question

for $question in $topQuestions
let $answers := /posts/row[@PostTypeId = 2 and @ParentId = $question/@Id]
let $topScore := max(for $score in $answers/@Score return xs:integer($score))
let $topAnswer :=
  if (empty($answers))
  then ()
  else $answers[$topScore = xs:integer(@Score)][1]

return
  <question>
    <title>{string($question/@Title)}</title>
    <body>{data($question/@Body)}</body>
    <score>{string($topScore)}</score>
    <tags>{string($question/@Tags)}</tags>
    {
      if (exists($topAnswer))
      then
        <top_answer>
          <body>{data($topAnswer/@Body)}</body>
          <score>{string($topAnswer/@Score)}</score>
          <vote_count>{string($topAnswer/@Score)}</vote_count>
        </top_answer>
      else ()
    }
  </question>
