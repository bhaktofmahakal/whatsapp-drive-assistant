# Twilio WhatsApp Setup Guide

This guide walks you through setting up Twilio WhatsApp integration for the Drive Assistant.

## Step 1: Create Twilio Account

1. Sign up at [Twilio Console](https://console.twilio.com/)
2. Verify your account and phone number
3. Note your Account SID and Auth Token

## Step 2: Set Up WhatsApp Sandbox

1. Go to **Messaging** → **Try it out** → **Send a WhatsApp message**
2. Follow the sandbox setup instructions
3. Note the sandbox phone number: `+1 415 523 8886`
4. Send "join [sandbox-code]" to the number from your phone

## Step 3: Configure Webhook

1. In Twilio Console → **Messaging** → **Settings** → **WhatsApp sandbox settings**
2. Set webhook URL to:
   ```
   https://your-domain.com:5678/webhook/whatsapp-webhook
   ```
   
   For local testing with ngrok:
   ```bash
   ngrok http 5678
   # Use the https URL: https://abc123.ngrok.io/webhook/whatsapp-webhook
   ```

3. Set HTTP method to **POST**

## Step 4: Test Connection

Send a test message to your sandbox number:
```
HELP
```

You should receive a response with available commands.

## Step 5: Production Setup (Optional)

For production use:

1. **Apply for WhatsApp Business API** access
2. **Verify your business** with Facebook
3. **Set up production webhook** URLs
4. **Configure rate limits** and monitoring

## Environment Variables

Add to your `.env` file:
```bash
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token_here
TWILIO_PHONE_NUMBER=whatsapp:+14155238886
```

## Testing Commands

Once setup is complete, test these commands:

### Basic Commands
```
HELP
LIST /
SUMMARY /path/to/document.pdf
DELETE /path/to/file.txt
```

### Response Format
All responses are formatted for WhatsApp with:
- Emojis for better UX
- Clear status messages
- Error handling
- Command help

## Troubleshooting

### Issue: "Webhook not receiving messages"
**Solutions:**
- Check webhook URL is publicly accessible
- Verify HTTPS is used (required by Twilio)
- Test webhook endpoint manually
- Check Twilio logs for delivery attempts

### Issue: "Messages not sending"
**Solutions:**
- Verify Twilio credentials
- Check account balance
- Confirm phone number is verified
- Review Twilio error logs

### Issue: "Sandbox limitations"
**Solutions:**
- Only verified numbers can use sandbox
- Limited to specific commands
- 24-hour session expiry
- Consider upgrading to production

## Webhook Security

For production, secure your webhook:

1. **Validate Twilio signature**:
```javascript
const crypto = require('crypto');

function validateTwilioSignature(signature, url, params) {
  const authToken = process.env.TWILIO_AUTH_TOKEN;
  const expectedSignature = crypto
    .createHmac('sha1', authToken)
    .update(Buffer.from(url + params, 'utf-8'))
    .digest('base64');
  
  return signature === expectedSignature;
}
```

2. **Use HTTPS only**
3. **Implement rate limiting**
4. **Log all webhook calls**

## Rate Limits

Twilio has rate limits:
- **1 message per second** per phone number
- **100 messages per day** (sandbox)
- **Higher limits** for production accounts

Plan your workflow accordingly and implement queuing if needed.

## Costs

### Sandbox
- **Free** for testing
- Limited functionality

### Production
- **$0.005** per WhatsApp message sent
- **No charge** for received messages
- Additional charges for media messages

## Support

- [Twilio WhatsApp API Documentation](https://www.twilio.com/docs/whatsapp)
- [Twilio Support](https://support.twilio.com/)
- [WhatsApp Business API Documentation](https://developers.facebook.com/docs/whatsapp)