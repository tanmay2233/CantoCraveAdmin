CantoCrave Project Report

Tanmay Jain 28 August, 2023

Introduction

CantoCrave is a canteen app that consists of two mobile applications: one for administrators and another for users. The application aims to streamline the canteen ordering process, allowing students to conveniently order food from their rooms, make payments, and collect their orders from the canteen.

Problem Statement

- Traditional canteen ordering systems can be time-consuming and incon- venient for both students and canteen staff specially when the crowd is large. Long queues and manual order processing can lead to inefficiencies and errors.
- There is a concern about the potential for spurious customers to exploit the system by showing fake transaction histories to the canteen staff. This undermines the trust in the payment and order management process.
- Additionally, users might face disappointment when they arrive at the canteen, expecting to enjoy their favorite dish, only to find that it’s un- available.
- CantoCrave aims to address these challenges by providing a user-friendly mobile app for ordering and payment.

Project Goals

The primary goals of CantoCrave are to:

- Provide a seamless ordering experience for users.
- Reduce waiting times and queues at the canteen.
- Improve order accuracy and payment efficiency.
- Empower canteen administrators with an app for order management.

Actors

In the CantoCrave app ecosystem, there are two primary actors: Admin and Users.

Admin

The Admin plays a pivotal role in managing the canteen operations and ensuring a smooth ordering process. Their responsibilities include:

- Menu Management: Updating items from the menu, including setting prices and availability.
- Order Processing: Reviewing incoming orders, preparing food, and marking orders as ready for pickup.
- Inventory Management: Monitoring the availability of ingredients and items to prevent stockouts.

Users

Users are the customers who interact with the app to order food from the canteen. Their roles and actions include:

- Browsing Menu: Viewing the available items, along with their descrip- tions and prices.
- Placing Orders: Selecting items, specifying quantities, and adding them to the cart for checkout.
- Payment: Making payments through the app using various payment methods for completed orders.

Methodology

Requirements Gathering and Analysis

In this phase, I, myself as a regular canteen service user understood the needs, expectations, and pain points.

Design

The design aimed to strike a balance between a visually appealing interface and user-friendly navigation. Feedback from friends played a crucial role in refining the design concepts.

Technology Selection

I opted for the Flutter framework for cross-platform mobile app development due to its rich UI capabilities and efficient development process. Firebase was chosen as the backend platform for its real-time database, user authentication, and cloud functions and storage.

Ongoing Testing

After implementation of a new feature it was tested for its performance on a real Android Device and the code was committed only after it pased all tests.

Technical Details

CantoCrave is built using the following technologies:

- Mobile App : Flutter framework for cross-platform development.
- Backend : Firebase for user authentication, real-time database, and cloud functions.
- Payment Integration : Integration with the upi~~ payment~~ qrcode~~ generator plugin that generates QR code for payment & payment status could be

shown at canteen. Improving the experience by introducing reliable UPI

payment integration due to the current issues with existing pub.dev plu-

gins.

- User Authentication : Google SignIn enabled for users whereas Admin has to login by entering userId & password.

Challenges and Solutions

Challenge 1: Payment Integration

Integrating a secure and reliable payment system was crucial for the success of the project. Initially, I explored various UPI payment integration plugins from pub.dev. However, I encountered multiple challenges with these plugins. They either lacked proper documentation, or were unable to handle certain UPI pay- ment flows effectively.

Due to the limitations of existing UPI payment plugins, I explored integrat- ing with RazorPay,but discovered that RazorPay has temporarily disabled new merchant onboarding, preventing from completing the integration as planned.

Solution: I focused on using the upi~~ payment~~ qrcode~~ generator plugin integration to provide a reliable and user-friendly payment experience to the

app users. I have kept the door open to revisit RazorPay integration once their

merchant onboarding is re-enabled or someone could suggest alternate way to integrate UPI payment.

Challenge 2 Design and UI Enhancement

Color Scheme Selection

Choosing an appealing and consistent color scheme that resonates with the app’s theme and user preferences was a critical design decision.

Solution: After thorough research and multiple iterations, I finalized a color scheme that balances aesthetics, readability, and user comfort.

AI-Generated Item Category Images

To achieve a polished and engaging user interface, I decided to use AI-generated images for item categories. The goal was to create a uniform and visually pleasing look for each category.

Solution: Utilized AI tools to generate item category images, allowing me to maintain a consistent visual style throughout the app. This approach resulted in a visually appealing UI.

Menu Items Image Enhancement

Enhancing the aesthetics of menu images required removing backgrounds and cropping images for a seamless appearance. While this process was time-consuming and tedious, it was a crucial step in ensuring that the UI looked polished and professional.

Solution: Despite the time and effort invested, I meticulously edited each menu image to remove backgrounds and crop them to fit the design. This atten- tion to detail contributed to the overall visual quality of the app’s user interface.

The challenges faced during the design and UI enhancement process highlight our commitment to delivering an exceptional user experience. By carefully selecting color schemes, incorporating AI-generated images, and meticulously editing menu images, I aimed to create a UI that not only looks good but also enhances the usability of the app.

Challenge 3 Real-Time Order Tracking

Concurrency Control for Available Quantities

One of the challenges I encountered was managing the available quantities of items in the canteen’s inventory to prevent overselling. I needed to ensure that users could only add items to their carts that were actually available in the inventory.

Solution: I implemented a concurrency control mechanism that checks the available quantity of an item in real time when a user attempts to add it to their cart. If the available quantity is sufficient, the item is added to the cart; otherwise, an appropriate message is displayed to inform the user about the shortage.

Quantity Validation During Checkout

To maintain accurate inventory records, I also needed to address the scenario where a user might add items to their cart but not proceed with the payment immediately or concurrently some other user might have ordered some of these items making their quantity insufficient. During checkout and payment, I needed to validate the cart items against the inventory to ensure that the ordered quantities were still available.

Solution: During the checkout process, I am verifying the cart items against the inventory once again. If any of the items’ quantities exceed the available stock, the user is notified, and they are prompted to adjust their order accord- ingly.

Future Scope

As CantoCrave lays the foundation for transforming the canteen experience, there are several exciting avenues for future development and expansion that can further enhance user convenience and satisfaction. The future scope includes:

Integration of Mess Menu

A significant enhancement in the pipeline is the seamless integration of the mess menu within the app. Currently, the mess menu is shared through a link on WhatsApp, which can be difficult to locate and access for users. By integrating the mess menu directly into the app, users will have instant access to the daily menu, special dishes, and meal schedules. This integration will create a one-stop solution for both ordering and menu reference, streamlining the user experience.

User Reviews and Ratings

Enabling users to leave reviews and ratings for dishes will foster a sense of community and provide valuable feedback to both the canteen staff and other users. This feature can assist new users in making informed choices and encour- age continuous improvement in the quality of offerings. The integration of the mess menu, along with these future developments, will position CantoCrave as a comprehensive solution that not only simplifies the ordering process but also enriches the overall canteen experience for users and administrators alike.

Conclusion

CantoCrave offers a modern and efficient solution to canteen ordering. By pro- viding a user-friendly interface, online payment options, and real-time order tracking, the app improves the overall ordering experience for users and admin- istrators.

GitHub Repository

The source code for CantoCrave can be found on GitHub: <https://github.com/tanmay2233/CantoCrave>

<https://github.com/tanmay2233/CantoCraveAdmin>

![](Aspose.Words.dd4d22a8-16c4-46bd-b59f-b8d0181aff54.001.png)
6
