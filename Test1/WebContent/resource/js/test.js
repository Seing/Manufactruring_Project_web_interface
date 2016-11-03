var svgHeight = 240;
var barElements;
var dataSet = [120, 70, 175, 80, 220];

console.log("this is working");

barElements = d3.select("#myGraph")
	.selectAll("rect")
	.data(dataSet)
	
barElements.enter()
	.append("rect")
	.attr("class","bar")
	.attr("height", function(d,i){
		return d;
	})
	.attr("width", 20)
	.attr("x", function(d,i){
		return i*25
	})
	.attr("y", function(d,i){
		return svgHeight -d;
	})				.selectAll("rect")
		.data(dataSet)
		.enter()
		.append("rect")