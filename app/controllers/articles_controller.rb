class ArticlesController < ApplicationController

before_action :set_article, only: [:edit, :update, :show, :destroy]


def index
	@articles = Article.all
end

def new
	@article = Article.new
end

def edit
	# prepare @article variable for the 'edit' template by calling before_action
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

def update
	# set article called via before_action

	if @article.update(article_params)
		flash[:notice] = "Article update succeded"
		redirect_to article_path(@article)	# show the edited article
	else
		render :edit  # render edit template once again if validation failed
	end
end

def show
	# before_action: find article in table Article by :id passed via GET request param (article/:id)
end

def destroy
	# before_action: find an article by :id passed via DELETE request
	@article.destroy

	flash[:notice] = "Article was successfully destroyed"
	redirect_to articles_path
end


private
	def set_article
		@article = Article.find(params[:id]) 	# find article in table Article by :id param
	end

	def article_params
		params.require(:article).permit(:title, :description)	# permit passing title & description via :article parameter	
	end
end