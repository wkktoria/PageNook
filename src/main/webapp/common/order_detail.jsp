<div class="center">
    <h3>Order Overview:</h3>
    <table>
        <tr>
            <td class="left"><b>Ordered by:</b></td>
            <td class="left">${order.customer.fullname}</td>
        </tr>
        <tr>
            <td class="left"><b>Order Status:</b></td>
            <td class="left">${order.status}</td>
        </tr>
        <tr>
            <td class="left"><b>Order Date:</b></td>
            <td class="left">${order.orderDate}</td>
        </tr>
        <tr>
            <td class="left"><b>Payment Method:</b></td>
            <td class="left">${order.paymentMethod}</td>
        </tr>
        <tr>
            <td class="left"><b>Book Copies:</b></td>
            <td class="left">${order.bookCopies}</td>
        </tr>
        <tr>
            <td class="left"><b>Total Amount:</b></td>
            <td class="left"><fmt:formatNumber value="${order.total}" type="currency"/></td>
        </tr>
    </table>
    <h3>Recipient Information:</h3>
    <table>
        <tr>
            <td class="left"><b>First Name:</b></td>
            <td class="left">${order.firstname}</td>
        </tr>
        <tr>
            <td class="left"><b>Last Name:</b></td>
            <td class="left">${order.lastname}</td>
        </tr>
        <tr>
            <td class="left"><b>Phone:</b></td>
            <td class="left">${order.phone}</td>
        </tr>
        <tr>
            <td class="left"><b>Address Line 1:</b></td>
            <td class="left">${order.addressLine1}</td>
        </tr>
        <tr>
            <td class="left"><b>Address Line 2:</b></td>
            <td class="left">${order.addressLine2}</td>
        </tr>
        <tr>
            <td class="left"><b>City:</b></td>
            <td class="left">${order.city}</td>
        </tr>
        <tr>
            <td class="left"><b>State:</b></td>
            <td class="left">${order.state}</td>
        </tr>
        <tr>
            <td class="left"><b>Country:</b></td>
            <td class="left">${order.countryName}</td>
        </tr>
        <tr>
            <td class="left"><b>Zipcode:</b></td>
            <td class="left">${order.zipcode}</td>
        </tr>
    </table>
</div>

<div class="center">
    <h3>Ordered Books</h3>
    <table>
        <tr>
            <th>Index</th>
            <th>Book Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
        </tr>
        <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${orderDetail.book.title}</td>
                <td>${orderDetail.book.author}</td>
                <td><fmt:formatNumber value="${orderDetail.book.price}" type="currency"/></td>
                <td>${orderDetail.quantity}</td>
                <td><fmt:formatNumber value="${orderDetail.subtotal}" type="currency"/></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="6" class="right">
                <p>Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency"/></p>
                <p>Tax: <fmt:formatNumber value="${order.tax}" type="currency"/></p>
                <p>Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type="currency"/></p>
                <b>TOTAL: <fmt:formatNumber value="${order.total}" type="currency"/></b>
            </td>
        </tr>
    </table>
</div>