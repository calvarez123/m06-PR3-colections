declare option output:method "xml";
declare option output:indent "yes";

(: Obtener las preguntas con más vistas :)
let $topQuestions :=
  for $question in /posts/row[@PostTypeId = 1]
  order by xs:integer($question/@ViewCount) descending
  return $question

(: Procesar las preguntas con más vistas :)
for $question in $topQuestions[position() <= 10] (: Tomar las 10 preguntas con más vistas :)
return
  <question>
    <title>{string($question/@Title)}</title>
    <body>{data($question/@Body)}</body>
  </question>
