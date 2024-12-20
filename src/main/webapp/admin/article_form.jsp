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
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
          integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script async src="../js/jquery.richtext.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.min.js"
            integrity="sha256-AlTido85uXPlSyyaZNsjJXeCs07eSv3r43kyCVc8ChI="
            crossorigin="anonymous"></script>
    <title><c:if test="${article != null}">Edit Article</c:if><c:if test="${article == null}">Create New Article</c:if>
        | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <c:choose>
        <c:when test="${article != null}">
            <c:set value="Edit Article" var="headingText"/>
        </c:when>
        <c:otherwise>
            <c:set value="Create New Article" var="headingText"/>
        </c:otherwise>
    </c:choose>
    <h1 class="page-heading">${headingText}</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <c:choose>
        <c:when test="${article != null}">
            <c:set value="update_article" var="formAction"/>
        </c:when>
        <c:otherwise>
            <c:set value="create_article" var="formAction"/>
        </c:otherwise>
    </c:choose>

    <form action="${formAction}" method="post" id="articleForm">
        <input type="hidden" name="articleId" value="${article.articleId}"/>
        <table class="form">
            <tr>
                <td class="left">Title:</td>
                <td class="left"><label for="title"></label><input id="title" type="text" name="title" size="20"
                                                                   value="${article.title}"/></td>
            </tr>
            <tr>
                <td class="left">Content:</td>
                <td class="left">
                    <label for="content"></label>
                    <textarea rows="5" cols="50" name="content" id="content">${article.content}</textarea>
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
        $("#content").richText();

        $("#articleForm").validate({
            rules: {
                title: "required",
                content: "required"
            },
            messages: {
                title: "Please enter a title of the article.",
                content: "Please enter a content of the article.",
            }
        });

        $("#buttonCancel").click(function () {
            history.back();
        });
    });
</script>
</body>
</html>
