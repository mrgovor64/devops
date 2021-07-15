var nodemailer = require('nodemailer');

var transporter = nodemailer.createTransport({
    host: 'email-smtp.us-east-1.amazonaws.com',
    port: 587, // SMTP PORT
    secure: false, // true for 465, false for other ports
    auth: {
        user: 'USER',
        pass: 'PASSWORD'
    }
});

exports.handler = (event, context, callback) => {
    
    console.log("event",event);
    let body_txt = '';

    if(event.Records !== undefined){
        for (let item of event.Records) {
            let detail = JSON.stringify(JSON.parse(item.Sns.Message).detail,null,'\t');
            body_txt += '<pre>'+detail+'</pre>';
            console.log("detail",detail);
        }
    }




    let mailOptions = {
        from: 'noreply@yourdomain.com',
        to: 'to@yourdomain.com',
        subject: 'SUBJECT',
        html: body_txt
    };

    transporter.sendMail(mailOptions);
};
