<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.min.js"
            integrity="sha256-AlTido85uXPlSyyaZNsjJXeCs07eSv3r43kyCVc8ChI="
            crossorigin="anonymous"></script>
    <title>Create New Book | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <c:choose>
        <c:when test="${book != null}">
            <c:set value="Edit Book" var="headingText"/>
        </c:when>
        <c:otherwise>
            <c:set value="Create New Book" var="headingText"/>
        </c:otherwise>
    </c:choose>
    <h1 class="page-heading">${headingText}</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <c:choose>
        <c:when test="${book != null}">
            <c:set value="update_book" var="formAction"/>
        </c:when>
        <c:otherwise>
            <c:set value="create_book" var="formAction"/>
        </c:otherwise>
    </c:choose>

    <form action="${formAction}" method="post" id="bookForm" enctype="multipart/form-data">
        <input type="hidden" name="bookId" value="${book.bookId}"/>
        <table class="form">
            <tr>
                <td>Category:</td>
                <td>
                    <label for="category">
                    </label>
                    <select name="category" id="category">
                        <c:forEach var="category" items="${listCategory}">
                            <c:if test="${category.categoryId eq book.category.categoryId}">
                                <option value="${category.categoryId}" selected>${category.name}</option>
                            </c:if>
                            <c:if test="${category.categoryId ne book.category.categoryId}">
                                <option value="${category.categoryId}">${category.name}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Title:</td>
                <td><label for="title"></label><input id="title" type="text" name="title" size="20"
                                                      value="${book.title}"/></td>
            </tr>
            <tr>
                <td>Author:</td>
                <td><label for="author"></label><input id="author" type="text" name="author" size="20"
                                                       value="${book.author}"/></td>
            </tr>
            <tr>
                <td>ISBN:</td>
                <td><label for="isbn"></label><input id="isbn" type="text" name="isbn" size="20"
                                                     value="${book.isbn}"/></td>
            </tr>
            <tr>
                <td>Publish Date:</td>
                <td><label for="publishDate"></label><input id="publishDate" type="text" name="publishDate"
                                                            size="20"
                                                            value="<fmt:formatDate pattern="MM/dd/yyyy" value='${book.publishDate}'/>"/>
                </td>
            </tr>
            <tr>
                <td>Book Image:</td>
                <td>
                    <label for="bookImage"></label><input id="bookImage" type="file" name="bookImage" size="20"/>
                    <br/>
                    <img id="thumbnail" alt="Image Preview" src="data:image/jpg;base64,${book.base64Image}"
                         style="width: 20%; margin-top: 10px;"/>
                </td>
            </tr>
            <tr>
                <td>Price:</td>
                <td><label for="price"></label><input id="price" type="text" name="price" size="20"
                                                      value="${book.price}"/></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td>
                    <label for="description"></label>
                    <textarea rows="5" cols="50" name="description" id="description">${book.description}</textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Save</button>
                    <button type="button" id="buttonCancel">Cancel</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $("#publishDate").datepicker();

        $("#bookImage").change(function () {
            showImageThumbnail(this);
        });

        $("#bookForm").validate({
            rules: {
                category: "required",
                title: "required",
                author: "required",
                isbn: "required",
                publishDate: "required",
                <c:if test="${book == null}">
                bookImage: "required",
                </c:if>
                price: "required",
                description: "required"
            },
            messages: {
                category: "Please select a category for the book.",
                title: "Please enter a title of the book.",
                author: "Please enter an author of the book.",
                isbn: "Please enter ISBN of the book.",
                publishDate: "Please enter a publish date of the book.",
                bookImage: "Please choose an image of the book.",
                price: "Please enter a price of the book.",
                description: "Please enter a description of the book.",
            }
        });

        $("#buttonCancel").click(function () {
            history.back();
        });
    });

    function showImageThumbnail(fileInput) {
        const file = fileInput.files[0];

        let reader = new FileReader();
        reader.onload = function (e) {
            $("#thumbnail").attr("src", e.target.result);
        };

        reader.readAsDataURL(file);
    }
</script>
</body>
</html>
