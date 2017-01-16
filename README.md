# spotdifference
Spot the Difference Game with JQuery

```
bower install spotdifference
```

# Example

```js
$(function () {

            new SpotDifference({
                image_div: "#findimage",
                map_name: "planetmap",
                class_mark: "mark fa fa-icon",
                onLoad: function (differences) {
                    console.log(differences);
                },
                onFind: function (finds, differences) {
                    console.log(finds + "/" + differences);
                },
                onEnd: function (time) {
                    console.log("End:" + time);
                }
            });

        });
```

```html
<body>

<h1>Spot the difference</h1>

<img src="img/1.jpg">

<div id="findimage" style="position: relative;">
    <img src="img/2.jpg" usemap="#planetmap">
</div>

<map id="mapgame" name="planetmap">
    <area shape="rect" coords="315,80,340,105" href="#">
    <area shape="rect" coords="145,170,250,185" href="#">
    <area shape="rect" coords="245,240,260,265" href="#">
    <area shape="rect" coords="60,345,65,370" href="#">
    <area shape="rect" coords="235,400,260,440" href="#">
</map>

```