create procedure p_score_update 
	@ddh	varchar(30)
as
begin
	declare	@score	

-- SET NOCOUNT ON;
	declare 	@khbh			varchar(21),
			@oldzxqk		varchar(2),
			@zxqk			varchar(2),
			@score			int,
			@totscore		int,
			@ecoid			uniqueidentifier,
			@yxwdbh			varchar(12),
			@ddh			varchar(30),
			@bz			nvarchar(max),
			@order_from     	varchar(10)



	select	@khbh = khbh,
		@ddh  = ddh,
		@zxqk = zxqk,
		@score=isnull(totscore,0) ,
		@order_from=Order_From
	from	t_pos_ghdd
	where	ddh = @ddh


-- 当订单由未签收状态变为签收时，增加会员积分
			update	t_khgl_khda
			set		score	 = score + @score,				--当前积分
					scoretot = scoretot + @score		--累计积分
			where	khbh = @khbh

			select	@ecoid = eco_id,
				@yxwdbh = yxwdbh
			from	t_khgl_khda
			where	khbh = @khbh

			-- 插入积分记录
			insert	dbo.t_shop_jfb (ECO_ID,ECO_TYPE,yxwdbh,jfly,sj,jf,pjbh,t_khgl_khda)
			values (newid(),50,@yxwdbh,'01',getdate(),@score,@ddh,@ecoid)
		




end




