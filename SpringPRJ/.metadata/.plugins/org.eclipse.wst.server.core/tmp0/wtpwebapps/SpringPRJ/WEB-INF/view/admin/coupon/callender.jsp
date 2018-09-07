<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<?xml version="1.0" encoding="utf-8"?>
<html>
<head>
	<title>Vanilla JS Calendar</title>
	<meta content="IE=edge" http-equiv="X-UA-Compatible">
	<meta content="width=device-width, initial-scale=1" name="viewport">
	<meta content="Chrissy Collins" name="author">
	<meta content="A pure vanilla JS calendar by @chrisssycollins" name="description">
	<link href="<%=request.getContextPath()%>/resources/css/admin/vanillaCalendar.css" rel="stylesheet">
	<style>

		.cal-container {
			width: 96%;
			margin: 1.6rem auto;
			max-width: 42rem;
			text-align: center;
		}

		.demo-picked {
			font-size: 1.2rem;
			text-align: center;
		}

		.demo-picked span {
			font-weight: bold;
		}
	</style>
</head>

<body>
	<div class="cal-container">
		<input type="hidden" value="" name="coupon_date1" id="coupon_date1">
		<input type="hidden" value="" name="coupon_date2" id="coupon_date2">
		<div id="v-cal">
			<div class="vcal-header">
				<button class="vcal-btn" data-calendar-toggle="previous">
					<svg height="24" version="1.1" viewbox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg">
						<path d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"></path>
					</svg>
				</button>

				<div class="vcal-header__label" data-calendar-label="month">
				</div>


				<button class="vcal-btn" data-calendar-toggle="next">
					<svg height="24" version="1.1" viewbox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg">
						<path d="M4,11V13H16L10.5,18.5L11.92,19.92L19.84,12L11.92,4.08L10.5,5.5L16,11H4Z"></path>
					</svg>
				</button>
			</div>
			<div class="vcal-week">
				<span>월</span>
				<span>화</span>
				<span>수</span>
				<span>목</span>
				<span>금</span>
				<span>토</span>
				<span>일</span>
			</div>
			<div class="vcal-body" data-calendar-area="month"></div>
		</div>

		<p class="demo-picked">
			<span data-calendar-label="picked"></span>
		</p>

	</div>
	<script src="<%=request.getContextPath()%>/resources/js/admin/vanillaCalendar.js" type="text/javascript"></script>
	<script>
		window.addEventListener('load', function () {
			vanillaCalendar.init({
				disablePastDays: true
			});
		})
	</script>
</body>

</html>