(: parse tests :)
<sales-qty-by-product>{
  for $sales in doc("sales-records.xml")/*/record
  let $pname := $sales/product-name
  group by $pname
  order by $pname
  return
    <product name="{$pname}">{
      sum($sales/qty)
    }</product>
}</sales-qty-by-product> 
%%%<result>{
  for $sales in doc("sales-records.xml")/*/record
  let $state := doc("stores.xml")/*/store[store-number = $sales/store-number]/state
  let $category := doc("products.xml")/*/product[name = $sales/product-name]/category
  group by $state, $category
  order by $state, $category
  return
    <group>
      <state>{$state}</state>
      <category>{$category}</category>
      <total-qty>{sum($sales/qty)}</total-qty>
    </group>
}</result>
%%%<result>{
  for $sales in doc("sales-records.xml")/*/record
  let $state := doc("stores.xml")/*/store[store-number = $sales/store-number]/state,
    $product := doc("products.xml")/*/product[name = $sales/product-name],
    $category := $product/category,
    $revenue := $sales/qty * $product/price
  group by $state, $category
  order by $state, $category
  return
    <group>
      <state>{$state}</state>
      <category>{$category}</category>
      <total-revenue>{sum($revenue)}</total-revenue>
    </group>
}</result>
%%%<result>{
  for $store in doc("stores.xml")/*/store
  let $state := $store/state
  group by $state
  order by $state
  return
    <state name="{$state}">{
      for $product in doc("products.xml")/*/product
      let $category := $product/category
      group by $category
      order by $category
      return
        <category name="{$category}">{
          for $sales in doc("sales-records.xml")/*/record[store-number = $store/store-number
            and product-name = $product/name]
          let $pname := $sales/product-name
          group by $pname
          order by $pname
          return
            <product name="{$pname}" total-qty="{sum($sales/qty)}" />
          }</category>
    }</state>
}</result>
%%%<result>{
  for $sales in doc("sales-records.xml")/*/record
  let $storeno := $sales/store-number
  group by $storeno
  order by $storeno
  return
    <store number = "{$storeno}">{
      for $s in $sales
      order by xs:int($s/qty) descending
      return
        <product name = "{$s/product-name}" qty = "{$s/qty}"/>
    }</store>
}</result>

%%%<result>{
  for $sales in doc("sales-records.xml")/*/record
  let $storeno := $sales/store-number,
    $product := doc("products.xml")/*/product[name = $sales/product-name],
    $prd := $product,
    $profit := $sales/qty * ($prd/price - $prd/cost)
  group by $storeno
  let $total-store-profit := sum($profit)
  where $total-store-profit > 100
  order by $total-store-profit descending
  return
    <store number = "{$storeno}" total-profit = "{$total-store-profit}"/>
 }</result>
%%%<result>{
  for $book in doc("books.xml")/*/book
  for $author in $book/author
  group by $author
  order by $author
  return
  <author name="{$author}">{
    for $b in $book
    order by $b/title
    return
      <title> {fn:data($b/title)} </title>
  }</author>
}</result>
%%%<result>{
  for $book in doc("books.xml")/*/book
  let $author-list := fn:string-join($book/author, ', ')
  group by $author-list
  order by $author-list
  return
    <author-list names="{$author-list}">{
      for $b in $book
      order by $b/title
      return
        <title> {fn:data($b/title)} </title>
    }</author-list>
}</result>
%%%declare variable $seq := fn:doc("arrange_rows.xml");

<table>{
  for tumbling window $w in $seq/doc/*
    start at $x when fn:true()
    end at $y when $y - $x = 2
  return
    <tr>{
      for $i in $w
      return
        <td>{data($i)}</td>
    }</tr>
}</table>

%%%declare variable $seq := fn:doc("head_para.xml");

<chapter>{
  for tumbling window $w in $seq/body/*
    start previous $s when $s[self::h2]
    end next $e when $e[self::h2]
  return
    <section title="{data($s)}">{
       for $x in $w
       return
         <para>{data($x)}</para>
  }</section>
}</chapter>
%%%declare variable $seq := fn:doc("term_def_list.xml");

<doc>{
for tumbling window $w in $seq/doc/*
  start $x when $x[self::dt]
  end $y next $z when $y[self::dd] and $z[self::dt]
return
  <term>{
    $w
  }</term>
}</doc>

%%%declare variable $timesequence := fn:doc("temp_events.xml");

let $MAX_DIFF := 2

for sliding window $w in $timesequence/stream/event
  start  $s_curr at $s_pos previous $s_prev
    when ($s_curr/@time ne $s_prev/@time) or (empty($s_prev))
  only end next $e_next
    when $e_next/@time - $s_curr/@time gt $MAX_DIFF
return
  avg( $w/@temp )


%%%declare variable $timesequence := fn:doc("temp_events.xml");
let $SMOOTH_CONST := 0.2

for sliding window $w in $timesequence/stream/event
  start at $s_pos when true()
  only end at $e_pos when $e_pos - $s_pos eq 2
return
  round-half-to-even($SMOOTH_CONST * data($w[3]/@temp) + (1 - $SMOOTH_CONST) *
    ( $SMOOTH_CONST * data($w[2]/@temp) +
      (1 - $SMOOTH_CONST) * data($w[1]/@temp) ), 2)

%%%declare variable $seq := fn:doc("temp_events.xml");

for sliding window $w in $seq/stream/event
  start  $s_curr when fn:true()
  only end next $next when $next/@time > $s_curr/@time + 3
return
  let $avg := fn:avg($w/@temp)
  where $avg * 2 lt xs:double($next/@temp) or $avg div 2 gt xs:double($next/@temp)
  return <alarm>Outlier detected. Event id:{data($next/@time)}</alarm>


%%%declare variable $seq := fn:doc("person_events.xml");

<result>{
  for tumbling window $w in $seq/stream/event
    start  $s when $s/person eq "Anton" and $s/direction eq "in"
    only end $e next $n when  xs:dateTime($n/@time) - xs:dateTime($s/@time) gt
      xs:dayTimeDuration("PT1H")
      or  ($e/person eq "Barbara" and $e/direction eq "in")
      or ($e/person eq "Anton" and $e/direction eq "out")
  where $e/person eq "Barbara" and $e/direction eq "in"
  return
    <warning time="{ $e/@time }">Barbara: Anton arrived 1h ago</warning>
}</result>

%%%declare variable $seq := fn:doc("person_events.xml");

<result>{
for sliding window $w in $seq/stream/event
  start  $s when $s/direction eq "in"
  only end  $e when $s/person eq $e/person and
    $e/direction eq "out"
return
  <working-time>
      {$s/person}
      <time>{ xs:dateTime($e/@time) - xs:dateTime($s/@time)}</time>
  </working-time>
}</result>
%%%declare variable $seq := fn:doc("person_events.xml");

<result>{
for sliding window $w in $seq/stream/event
  start  $s when $s/direction eq "in"
  only end  $e when $s/person eq $e/person and
    $e/direction eq "out"
let $person := $s/person
let $workingTime := xs:dateTime($e/@time) - xs:dateTime($s/@time)
group by $person
order by $person
return
  <working-time>
    <person>{ $person }</person>
    <time>{ sum($workingTime) }</time>
  </working-time>
}</result>
%%%declare variable $seq := fn:doc("person_events.xml");

<result>{
  for tumbling window $w in $seq/stream/event[direction eq "in"]
    start  $s when fn:true()
    end next $e when xs:date( xs:dateTime($s/@time) ) ne xs:date( xs:dateTime($e/@time) )
  let $date := xs:date(xs:dateTime($s/@time))
  where not($w[person eq "Barbara"])
  return <alert date="{ $date }">Barbara did not come to work</alert>
}</result>

%%%declare variable $seq := fn:doc("person_events.xml");

<results>{
  for tumbling window $w in $seq/stream/event[direction eq "in"]
    start when true()
    only end next $x when  $x/person eq "Clara"
  return
    <result time="{ $x/@time }">{
      distinct-values(for $y in $w
        where (xs:dateTime($y/@time) + xs:dayTimeDuration("PT15M") ) ge xs:dateTime($x/@time)
        return $y/person)
    }</result>
}</results>

%%%declare variable $seq := fn:doc("person_events.xml");

<result>{
	for tumbling window $w in $seq/stream/event[direction eq "in"]
		start  $x when $x/person = ("Barbara", "Anton")
		end next $y when xs:dateTime($y/@time) - xs:dateTime($x/@time) gt xs:dayTimeDuration("PT30M")
	where $w[person eq "Anton"] and $w[person eq "Barbara"]
	return
		<alert time="{ xs:dateTime($y/@time) }">Anton and Barbara just arrived</alert>
}</result>
%%%declare variable $seq := fn:doc("person_events.xml");

<result>{
  for sliding window $w in $seq/stream/event
    start  $s when true()
    end next $e when xs:dateTime($e/@time) - xs:dateTime($s/@time) gt
      xs:dayTimeDuration("PT1H")
  where count($w[person eq $s/person and direction eq "in"]) ge 3
  return
    <alert time="{ $e/@time }">{fn:data($s/person)} is suspicious</alert>
}</result>
%%%declare variable $rssfeed := fn:doc("rss.xml");

<result>{
  for tumbling window $w in $rssfeed/rss/channel/item
    start  $first when fn:true()
    end next $lookAhead when $first/author ne $lookAhead/author
  where count($w) ge 3
  return <annoying-author>{
      $w[1]/author
    }</annoying-author>
}</result>
%%%declare variable $rssfeed := fn:doc("rss.xml");

<result>{
  for tumbling window $w in $rssfeed/rss/channel/item
    start  $s_curr when true()
    end next $e_next when
      fn:day-from-dateTime(xs:dateTime($e_next/pubDate)) ne
      fn:day-from-dateTime(xs:dateTime($s_curr/pubDate))
  return
    <item>
        <date>{xs:date(xs:dateTime($s_curr/pubDate))}</date>
        {  for $item in $w
		   where fn:contains( xs:string($item/title), 'XQuery')
		   return $item/title	}
      </item>
}</result>

%%%declare variable $rssfeed := fn:doc("rss.xml");

<result>{
  for tumbling window $w in $rssfeed/rss/channel/item
    start  $s_curr when true()
    end next $e_next when
      fn:day-from-dateTime(xs:dateTime($e_next/pubDate)) ne
      fn:day-from-dateTime(xs:dateTime($s_curr/pubDate))
  return
    <item>
      <date>{xs:date(xs:dateTime($s_curr/pubDate))}</date>
       {  for $a in fn:distinct-values($w/author)
           return
             <author name="{$a}">
               <titles>
                 { $w[author eq $a]/title }
               </titles>
			</author>
	    }
	  </item>
}</result>
%%%declare variable $seq := fn:doc("cxml.xml");

<result>{
for sliding window $w in $seq/sequence/*
  start  $cur previous $prev
   when day-from-dateTime($cur/@date) ne day-from-dateTime($prev/@date) or empty($prev)
  end $end next $next
   when day-from-dateTime(xs:dateTime($end/@date)) ne
day-from-dateTime(xs:dateTime($next/@date))
return
  <mostValuableCustomer endOfDay="{xs:dateTime($cur/@date)}">{
    let $companies :=	for $x in distinct-values($w/@billTo )
                        return <amount company="{$x}">{sum($w[@billTo eq $x]/@total)}</amount>
    let $max := max($companies)
    for $company in $companies
    where $company eq xs:untypedAtomic($max)
    return $company
  }</mostValuableCustomer>
}</result>
%%%declare variable $seq := fn:doc("cxml.xml");

<result>{
  for sliding window $w in $seq/sequence/*
    start $s when $s[self::OrderRequest]
    end   $e when $e/@orderID eq  $s/@orderID
             and ($e[self::ConfirmationRequest] and $e/@status eq "reject"
                  or $e[self::ShipNotice])
  where $e[self::ShipNotice]
  return
    <timeToShip orderID="{ $s/@orderID}">{xs:dateTime($e/@date) - xs:dateTime($s/@date) }</timeToShip>
}</result>
%%%declare variable $seq := fn:doc("cxml.xml");

<result>{
  for sliding window $w in $seq/sequence/*
    start previous $wSPrev when $wSPrev[self::OrderRequest]
    end next $wENext when $wENext/@orderID eq  $wSPrev/@orderID
        and ($wENext[self::ConfirmationRequest] and $wENext/@status eq "reject"
	         or $wENext[self::ShipNotice])
  where $wENext[self::ShipNotice]
  return
    <bundleWith orderId="{$wSPrev/@orderID}">{
        for sliding window $bundle in $w
          start  $bSCur
            when $bSCur[self::OrderRequest] and $bSCur/@shipTo eq $wSPrev/@shipTo
          end  $bECur next $bENext
            when $bECur/@orderID eq  $bSCur/@orderID
             and ($bECur[self::ConfirmationRequest] and $bECur/@status eq "reject"
              or $bECur[self::ShipNotice])
          where empty($bENext)
          return $bSCur
    }</bundleWith>
}</result>
%%%<products>{
    for $product in doc("products.xml")/*/product
    order by $product/name
    count $number
    return
        <product number="{$number}">{$product/*}</product>
}</products>
%%%declare variable $seq := fn:doc("arrange_rows.xml");

<table>{
  for tumbling  window $w in $seq/doc/*
    start at $x when fn:true()
    end at $y when $y - $x = 2
  count $rowNumber
  return
    <tr>
      <td>{$rowNumber}</td>{
      for $i in $w
      return
        <td>{data($i)}</td>
    }</tr>
}</table>

%%%<result>{
    for $sales in doc("sales-records.xml")/*/record
    let $name := $sales/product-name
    group by $name
    let $qty := sum($sales/qty)
    order by $qty descending
    count $count
    where $count <= 3
    return
        <sale product="{$name}" qty="{$qty }"/>
}</result>
%%%<result>{
    for $store in doc("stores.xml")/*/store
    for $sale allowing empty in doc("sales-records.xml")/*/record[
         store-number eq $store/store-number]
    return
      <store number="{$store/store-number}"
         product="{$sale/product-name}"
         state="{$store/state}"
         sold="{$sale/qty}" />
}</result>
%%%<result>{
for $store in doc("stores.xml")/*/store
for $product in doc("products.xml")/*/product
for $sale allowing empty in doc("sales-records.xml")/*/record[
     store-number eq $store/store-number and
     product-name eq $product/name]
return
  <store number="{$store/store-number}"
      state="{$store/state}"
      product="{$sale/product-name}"
      sold="{$sale/qty}" />
}</result>
%%%try {
    <result>{
        for $product in fn:doc("product-err.xml")//product
        return
            <product>{$product/name}
            <margin>{$product/price - $product/cost}</margin>
            </product>
    }</result>
} catch * {
     "An error occured, please ask your consultant for help."
}

%%%<result>{
    for $product in fn:doc("product-err.xml")//product
    return
         try {
            <product>{$product/name}
              <margin>{$product/price div $product/cost}</margin>
            </product>
        } catch * {
            <product>{
                ($product/name, "Error:", $err:code)
            }</product>
        }
}</result>

%%%declare namespace foo='http://foo.com';
declare function local:fib-recur($n as xs:integer) as xs:integer? {
    if ($n <0) then ()
    else if ($n > 100) then
        fn:error(fn:QName('http://foo.com', 'ValueToBig'), 'Value too big')
    else if ($n = 0)  then 0
    else if ($n=1)   then 1
    else local:fib-recur($n - 1)  + local:fib-recur($n - 2)
};

<result>{
    for $x in (3,1,1030,5)
    return
        try{
        <fib input="{$x}">{local:fib-recur($x)}</fib>
        }catch foo:ValueToBig {
          <fib input="{$x}">Number to big</fib>
        }
}</result>
%%%