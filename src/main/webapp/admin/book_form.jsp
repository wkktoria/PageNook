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
    <link rel="stylesheet" href="../css/richtext.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
          integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script async src="../js/jquery.richtext.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <title><c:if test="${book != null}">Edit Book</c:if><c:if test="${book == null}">Create New Book</c:if> | PageNook -
        Administration</title>
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
                                                      value="${book.title}" required/></td>
            </tr>
            <tr>
                <td>Author:</td>
                <td><label for="author"></label><input id="author" type="text" name="author" size="20"
                                                       value="${book.author}" required/></td>
            </tr>
            <tr>
                <td>ISBN:</td>
                <td><label for="isbn"></label><input id="isbn" type="text" name="isbn" size="20"
                                                     value="${book.isbn}" required/></td>
            </tr>
            <tr>
                <td>Publish Date:</td>
                <td><label for="publishDate"></label><input id="publishDate" type="date" name="publishDate"
                                                            size="20"
                                                            value="<fmt:formatDate pattern="yyyy-MM-dd" value='${book.publishDate}'/>"
                                                            required/>
                </td>
            </tr>
            <tr>
                <td>Book Image:</td>
                <td>
                    <c:if test="${book == null}">
                        <label for="bookImage"></label>
                        <input id="bookImage" type="file" name="bookImage" size="20" required/>
                    </c:if>
                    <c:if test="${book != null}">
                        <label for="bookImage"></label>
                        <input id="bookImage" type="file" name="bookImage" size="20"/>
                    </c:if>
                    <br/>
                    <img id="thumbnail" alt="Image Preview" src="data:image/jpg;base64,${book.base64Image}"
                         style="width: 20%; margin-top: 10px;"/>
                </td>
            </tr>
            <tr>
                <td>Price:</td>
                <td><label for="price"></label><input id="price" type="text" name="price" size="20"
                                                      value="${book.price}" required/></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td>
                    <label for="description"></label>
                    <textarea rows="5" cols="50" name="description" id="description"
                              required>${book.description}</textarea>
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
        $("#description").richText();

        $("#bookImage").change(function () {
            showImageThumbnail(this);
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
