class Api::V1::PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :authorized, except: [:index , :show]
    def index
        @posts = Post.all
        render "index.json"
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            render "show.json", status: :created
        else
            render json: "error" , status: :unprocessable_entity
        end
    end

    def show 
        render "show.json"
    end

    def update
        if @post.update(post_params)
            render "show.json", status: :ok
        else
            render json: "error", status: :unprocessable_entity
        end
    end

    def destroy
        @post.destroy
        render json: "deleted successfully", status: :ok
    end
    private
        def set_post
            @post = Post.find(params[:id])
        end
        def post_params
            params.require(:post).permit(:title , :body)
        end
end
