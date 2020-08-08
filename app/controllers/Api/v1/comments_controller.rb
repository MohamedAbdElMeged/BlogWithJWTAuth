class Api::V1::CommentsController < ApplicationController
    before_action :set_comment, only: [:show , :update , :destroy]
    def index 
        @comments = Comment.where(post_id: params[:post_id])
        render "index.json"
    end
    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            render "show.json", status: :created
        else
            render json: @comment.errors , status: :unprocessable_entity
        end
    end
    def show
        render "show.json"
    end
    def update
        if @comment.update(comment_params)
            render "show.json", status: :ok
        else
            render json: @comment.erros, status: :unprocessable_entity
            render json: @comment.erros, status: :unprocessable_entity
        end 
    end
    def destroy
        @comment.destroy
        render json: "deleted successfully", status: :ok
    end
    private
        def set_comment
            @comment = Comment.find(params[:id])
        end
        def comment_params
            params.require(:comment).permit(:body , :post_id)
        end
end
