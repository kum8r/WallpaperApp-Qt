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

var getSubCategoryList = function (id) {
    var res = getUrl(website_url + "&method=sub_category_list&id=" + id)
    var json_obj = JSON.parse(res)
    return json_obj["sub-categories"]
}

var getCategoryWallpaper = function (id, pageNo) {
    var res = getUrl(
                website_url + "&method=category&id=" + id + "&page=" + pageNo)
    var json_obj = JSON.parse(res)
    return json_obj.wallpapers
}

var getSubCategoryWallpaper = function (id, pageNo) {
    var res = getUrl(
                website_url + "&method=sub_category&id=" + id + "&page=" + pageNo)
    var json_obj = JSON.parse(res)
    return json_obj.wallpapers
}

var searchWallpaper = function (searchtext, pageNo) {
    var res = getUrl(website_url + "&method=search&term=" + searchtext)
    var json_obj = JSON.parse(res)
    return json_obj.wallpapers
}

var getWallpaperInfo = function (id) {
    var res = getUrl(website_url + "&method=wallpaper_info&id=" + id)
    var json_obj = JSON.parse(res)
    return json_obj.wallpaper
}

WorkerScript.onMessage = function (message) {
    var pageNo = message.pageNo
    var imageType = message.imageType
    var categoryId = message.categoryId

    if (imageType === "popular") {
        var popularWallpapers = getPopularImagesThumb(pageNo)
        WorkerScript.sendMessage({
                                     "images": popularWallpapers
                                 })
    } else if (imageType === "featured") {
        var featureWallpapers = getFeaturedImagesThumb(pageNo)
        WorkerScript.sendMessage({
                                     "images": featureWallpapers
                                 })
    } else if (imageType === "newest") {
        var newestWallpapers = getNewestImagesThumb(pageNo)
        WorkerScript.sendMessage({
                                     "images": newestWallpapers
                                 })
    } else if (imageType === "category") {
        var categoryWallpaper = getCategoryWallpaper(categoryId, pageNo)
        WorkerScript.sendMessage({
                                     "images": categoryWallpaper
                                 })
    } else if (imageType === "subcategory") {
        var subCategoryWallpaper = getSubCategoryWallpaper(categoryId, pageNo)
        WorkerScript.sendMessage({
                                     "images": subCategoryWallpaper
                                 })
    } else if (imageType === "categorylist") {
        var categoryList = getCategoryList()
        WorkerScript.sendMessage({
                                     "list": categoryList
                                 })
    } else if (imageType === "subcategorylist") {
        var subCategoryList = getSubCategoryList(categoryId)
        console.log(subCategoryList)
        WorkerScript.sendMessage({
                                     "list": subCategoryList
                                 })
    } else if (imageType === "search") {
        var searchText = message.searchText
        var wallpaper = searchWallpaper(searchText, pageNo)
        WorkerScript.sendMessage({
                                     "images": wallpaper
                                 })
    }
}
