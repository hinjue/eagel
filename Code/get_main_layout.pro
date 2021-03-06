;+
; NAME:
;       get_main_layout
;
; PURPOSE:
;       get the main layout of the widget
;
; CALLING SEQUENCE:
;       base = get_main_layout(date_time, 0, btnArr = btns, widPos)
;
; INPUTS:
;       datetime: date and time that should be shown in the widget
;		sensitive: button sensitivity (1 for sensitive, 0 for insensitive)
;		offsetPos: Position of the window on the screen
;
; OUTPUTS:
;       base: id of the widget
;
; KEYWORDS:
;		btnArr: array with buttons on the widget
;
; MODIFICATION HISTORY:
;       20180711: created by jhinterreiter
;-
function get_main_layout, datetime, sensitive, btnArr = btnArr, offsetPos
	common realTimeImages, rtActive

	xsize = offsetPos[0]
	ysize = offsetPos[1]
	title = 'EAGEL Tool'


	base = widget_base(xsize = xsize, ysize = ysize, frame = 0, title = title, /column, xoffset = offsetPos[2], yoffset = offsetPos[3])
	labStartDate = widget_label(base, value = 'Date:', /align_left, yoffset = 10)
	txtStartDate = widget_text(base, value = datetime, uname = 'txtStart', xoffset = 100, /editable, /all_events, tab_mode = 1, sensitive = sensitive);, event_pro='test_event')

	cbBase = Widget_Base(base, Title='', /ROW, /ALIGN_CENTER, /NonExclusive)
	baseButtons = WIDGET_BASE(base, /ROW, /ALIGN_CENTER, tab_mode = 1)
	cbRealtime =  Widget_Button(cbBase, Value='Realtime Images', uvalue='rtImages', event_pro = 'rtImages_event', sensitive = sensitive)

	btnDownload = WIDGET_BUTTON(baseButtons, VALUE='Download Images', uvalue='DWLDIMGS', event_pro='downloadImgs_event', tab_mode = 1, sensitive = sensitive)
	btnPrepare = WIDGET_BUTTON(baseButtons, VALUE='Prepare Images', uvalue='PrepData', event_pro = 'prepare_event', tab_mode = 1, sensitive = sensitive)
	btnRunGCS = WIDGET_BUTTON(baseButtons, VALUE='Run GCS', uvalue='runGCS', event_pro = 'runGCS_event', tab_mode = 1, sensitive = sensitive)
	btnCreateEC = WIDGET_BUTTON(baseButtons, VALUE='Create EC cut', uvalue='createECcut', event_pro = 'createECcut_event', tab_mode = 1, sensitive = sensitive)
	;btnRunGCS = WIDGET_BUTTON(baseButtons, VALUE='run GCS', uvalue='RUN_GCS', event_pro = 'runGCS_event', /tab_mode);, sensitive= 1)

	
	btnClose = WIDGET_BUTTON(baseButtons, VALUE='Close', uvalue = 'CLOSE', event_pro = 'close_event', tab_mode = 1, sensitive =sensitive)

	if rtActive eq 1 then widget_control, cbRealtime, /set_button

	childBtns = widget_info(baseButtons, /all_children)
	n_btns = widget_info(baseButtons, /n_children)

	btnArr = intarr(n_btns+1)
	for i = 0, n_btns-1 do begin
		btnArr[i] = childBtns[i]
	endfor
	btnArr[i] = txtStartDate


	baseTexts = WIDGET_BASE(base, /COLUMN, /ALIGN_Left, /tab_mode)
	labEmpty = widget_label(baseTexts, value = '', /align_left)
	labExpl = widget_label(baseTexts, value = 'Date:', /align_left)
	labExpl = widget_label(baseTexts, value = '    Date and time of the event (Format is YYYYMMDDThh:mm:ss)', /align_left)
	labEmpty = widget_label(baseTexts, value = '', /align_left)
;	labExpl = widget_label(baseTexts, value = 'Realtime Images:', /align_left)
;	labExpl = widget_label(baseTexts, value = '    Select to ', /align_left)
;	labEmpty = widget_label(baseTexts, value = '', /align_left)
	labExpl = widget_label(baseTexts, value = 'Button "Download Images":', /align_left)
	labExpl = widget_label(baseTexts, value = '    Downloading of the coronagraph images', /align_left)
	labExpl = widget_label(baseTexts, value = 'Button "Prepare Images":', /align_left)
	labExpl = widget_label(baseTexts, value = '    Processing of coronagraph images (Modes: direct, base, running difference)', /align_left)
	labEmpty = widget_label(baseTexts, value = '', /align_left)
	labExpl = widget_label(baseTexts, value = 'Button "Run GCS":', /align_left)
	labExpl = widget_label(baseTexts, value = '    Opens GCS gui', /align_left)
	labEmpty = widget_label(baseTexts, value = '', /align_left)
	labExpl = widget_label(baseTexts, value = 'Button "Create EC cut":', /align_left)
	labExpl = widget_label(baseTexts, value = '    Creates ecliptic cut of the GCS wire frame', /align_left)
	labEmpty = widget_label(baseTexts, value = '', /align_left)
	
	


	return, base
end