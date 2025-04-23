<table class="form">
    <tr>
        <td class="right">E-mail:</td>
        <td class="left"><label for="email"></label><input id="email" type="text" name="email" size="45"
                                                           value="${customer.email}"/></td>
    </tr>
    <tr>
        <td class="right">First Name:</td>
        <td class="left">
            <label for="firstname"></label>
            <input id="firstname" type="text" name="firstname" size="45" value="${customer.firstname}"/>
        </td>
    </tr>
    <tr>
        <td class="right">Last Name:</td>
        <td class="left">
            <label for="lastname"></label>
            <input id="lastname" type="text" name="lastname" size="45" value="${customer.lastname}"/>
        </td>
    </tr>
    <tr>
        <td class="right">Password:</td>
        <td class="left">
            <label for="password"></label>
            <input id="password" type="password" name="password" size="45" value="${customer.password}"
                   <c:if test="${customer != null}">readonly</c:if>/>
        </td>
    </tr>
    <tr>
        <td class="right">Confirm Password:</td>
        <td class="left">
            <label for="confirmPassword"></label>
            <input id="confirmPassword" type="password" name="confirmPassword" size="45" value="${customer.password}"
                   <c:if test="${customer != null}">readonly</c:if>/>
        </td>
    </tr>
    <tr>
        <td class="right">Phone Number:</td>
        <td class="left"><label for="phone"></label><input id="phone" type="text" name="phone" size="45"
                                                           value="${customer.phone}"/>
        </td>
    </tr>
    <tr>
        <td class="right">Address Line 1:</td>
        <td class="left">
            <label for="address1"></label>
            <input id="address1" type="text" name="address1" size="45" value="${customer.addressLine1}"/>
        </td>
    </tr>
    <tr>
        <td class="right">Address Line 2:</td>
        <td class="left">
            <label for="address2"></label>
            <input id="address2" type="text" name="address2" size="45" value="${customer.addressLine2}"/>
        </td>
    </tr>
    <tr>
        <td class="right">City:</td>
        <td class="left">
            <label for="city"></label>
            <input id="city" type="text" name="city" size="45" value="${customer.city}"/>
        </td>
    </tr>
    <tr>
        <td class="right">State:</td>
        <td class="left">
            <label for="state"></label>
            <input id="state" type="text" name="state" size="45" value="${customer.state}"/>
        </td>
    </tr>
    <tr>
        <td class="right">Zip Code:</td>
        <td class="left"><label for="zipcode"></label><input id="zipcode" type="text" name="zipcode" size="45"
                                                             value="${customer.zipcode}"/></td>
    </tr>
    <tr>
        <td class="right">Country:</td>
        <td class="left">
            <label for="country"></label>
            <select name="country" id="country">
                <c:forEach items="${mapCountries}" var="country">
                    <option value="${country.value}"
                            <c:if test="${customer.country eq country.value}">selected</c:if>>${country.key}</option>
                </c:forEach>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <button type="submit">Save</button>
            <button type="button" onclick="history.back()">Cancel</button>
        </td>
    </tr>
</table>
