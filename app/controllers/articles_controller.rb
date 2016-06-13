class ArticlesController < ApplicationController

	def new
		@article = Article.new
	end

	def create
		# display plain text contents of :article param
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
		
		if @article.save
			flash[:notice] = "Operation succeded!"  # pass flash named ":notice" to application layout html
			# redirecting to show method passing current @article instance variable, containing created article
			redirect_to article_path(@article)
		else
			render :new
		end
	end

	def show
		@article = Article.find(params[:id])	# find article in table Article by :id passed via GET request param (article/:id)
	end

private
	def article_params
		params.require(:article).permit(:title, :description)	# permit passing title & description via :article parameter	
	end
end