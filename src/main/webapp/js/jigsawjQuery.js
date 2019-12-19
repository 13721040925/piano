$(function () {
   var l = 42; // 滑块边长
   var  r = 10; // 滑块半径
    var  w = 310; // canvas宽度
    var  h = 155; // canvas高度
    var  PI = Math.PI;
    var L = l + r * 2 // 滑块实际边长
});
function getRandomNumberByRange(start, end) {
    return Math.round(Math.random() * (end - start) + start)
}
function getRandomImg() {
    return 'https://picsum.photos/300/150/?image=' + getRandomNumberByRange(0, 100)
}
function createCanvas(width, height) {
    var canvas=$("<canvas style='width:"+width+";height:"+height+";'></canvas>")
    return canvas
}