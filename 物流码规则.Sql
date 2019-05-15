select 	a.wlbh, a.djrq,a.*
from 	t_khgl_khxx a with (nolock) 
where	a.wlbh <> ''
order by a.djrq desc