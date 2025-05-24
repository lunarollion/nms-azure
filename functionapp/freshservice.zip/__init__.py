import logging
import json
import os
import requests # type: ignore
import azure.functions as func # type: ignore

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Processing alert to create Freshservice ticket.')

    # Get Freshservice API details from environment variables
    freshservice_api_key = os.getenv('FRESHSERVICE_API_KEY')
    freshservice_domain = os.getenv('FRESHSERVICE_DOMAIN')

    if not freshservice_api_key or not freshservice_domain:
        logging.error("Freshservice API credentials are missing.")
        return func.HttpResponse(
            "Freshservice credentials not configured.",
            status_code=500
        )

    try:
        alert = req.get_json()
        logging.info(f"Received alert payload: {alert}")
    except ValueError:
        logging.error("Invalid JSON received.")
        return func.HttpResponse(
            "Invalid JSON body.",
            status_code=400
        )

    alert_name = alert.get('alertName') or alert.get('data', {}).get('alertName') or "No Alert Name"

    ticket_data = {
        "helpdesk_ticket": {
            "subject": f"Alert: {alert_name}",
            "description": json.dumps(alert, indent=2),
            "email": "alerts@yourcompany.com",
            "priority": 1,
            "status": 2
        }
    }

    url = f"https://{freshservice_domain}/api/v2/tickets"
    headers = {
        "Content-Type": "application/json"
    }
    auth = (freshservice_api_key, "X")

    response = requests.post(url, headers=headers, auth=auth, json=ticket_data)

    if response.status_code == 201:
        logging.info("Ticket created successfully in Freshservice.")
        return func.HttpResponse("Ticket created successfully.", status_code=201)
    else:
        logging.error(f"Failed to create ticket. Status: {response.status_code}, Response: {response.text}")
        return func.HttpResponse(f"Failed to create ticket: {response.text}", status_code=500)
