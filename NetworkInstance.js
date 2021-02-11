"use strict"

const API_KEY = "07c637348631ce7e9573cb6d562339a2"
const BASE_URL = "https://wall.alphacoders.com/api2.0/get.php?"

const website_url = BASE_URL + "auth=" + API_KEY

var getUrl = function Get(yourUrl) {
    var Httpreq = new XMLHttpRequest()
    Httpreq.open("GET", yourUrl, false)
    Httpreq.send(null)
    return Httpreq.responseText
}

var getNewestImagesThumb = function (pageNo) {
    var res = getUrl(website_url + "&method=newest&page=" + pageNo)
    var json_obj = JSON.parse(res)
    return json_obj.wallpapers
}

var getFeaturedImagesThumb = function (pageNo) {
    var res = getUrl(website_url + "&method=featured&page=" + pageNo)
    var json_obj = JSON.parse(res)
    return json_obj.wallpapers
}

var getPopularImagesThumb = function (pageNo) {
    var res = getUrl(website_url + "&method=popular&page=" + pageNo)
    var json_obj = JSON.parse(res)
    return json_obj.wallpapers
}

var getCategoryList = function () {
    var res = getUrl(website_url + "&method=category_list")
    var json_obj = JSON.parse(res)
    return json_obj.categories
}

var getCategoryWallpaper = function (id, pageNo) {
    var res = getUrl(
                website_url + "&method=category&id=" + id + "&page=" + pageNo)
    var json_obj = JSON.parse(res)
    return json_obj.wallpapers
}

var getSubCategoryList = function (id) {
    var res = getUrl(website_url + "&method=sub_category_list&id=" + id)
    var json_obj = JSON.parse(res)
    return json_obj["sub-categories"]
}

function downloadFile(url) {
    const http = require('http'); // or 'https' for https:// URLs
    const fs = require('fs');

    const file = fs.createWriteStream("file.jpg");
    const request = http.get(url, function(response) {
      response.pipe(file);
    });
}
