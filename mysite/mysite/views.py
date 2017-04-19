from django.http import HttpResponse
import datetime


def current_datetime(request):
    now = datetime.datetime.now()
    html = "<html><body>The current time is %s.</body></html>" % now
    return HttpResponse(html)
